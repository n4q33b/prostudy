-- ProStudy Database Schema
-- Supabase PostgreSQL with pgvector

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "vector";

-- ============================================
-- USERS (synced from Firebase Auth)
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    firebase_uid TEXT UNIQUE NOT NULL,
    email TEXT,
    display_name TEXT,
    board TEXT NOT NULL DEFAULT 'maharashtra',  -- maharashtra, cbse
    class INTEGER NOT NULL DEFAULT 7 CHECK (class >= 5 AND class <= 10),
    medium TEXT NOT NULL DEFAULT 'english',     -- marathi, hindi, english, urdu, semi-english
    enrolled_year INTEGER NOT NULL DEFAULT 2026,
    subscription_tier TEXT DEFAULT 'free',      -- free, class5-6, class7-8-9, class10
    daily_credits INTEGER DEFAULT 5,
    credits_reset_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_users_firebase_uid ON users(firebase_uid);
CREATE INDEX idx_users_board_class ON users(board, class);

-- ============================================
-- SYLLABUS VERSIONS
-- ============================================
CREATE TABLE IF NOT EXISTS syllabus_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    board TEXT NOT NULL,
    year INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'draft',  -- draft, active, archived
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(board, year)
);

-- Insert current syllabus
INSERT INTO syllabus_versions (board, year, status) VALUES
    ('maharashtra', 2026, 'active'),
    ('cbse', 2026, 'draft')
ON CONFLICT DO NOTHING;

-- ============================================
-- SUBJECTS
-- ============================================
CREATE TABLE IF NOT EXISTS subjects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    board TEXT NOT NULL,
    class INTEGER NOT NULL,
    code TEXT NOT NULL,                    -- science, maths, marathi, etc.
    name_en TEXT NOT NULL,
    name_mr TEXT,
    name_hi TEXT,
    icon TEXT,
    color TEXT,                            -- gradient color for UI
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(board, class, code)
);

CREATE INDEX idx_subjects_board_class ON subjects(board, class);

-- ============================================
-- CHAPTERS
-- ============================================
CREATE TABLE IF NOT EXISTS chapters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE,
    chapter_number INTEGER NOT NULL,
    code TEXT NOT NULL,                    -- ch01, ch02, etc.
    name_en TEXT NOT NULL,
    name_mr TEXT,
    name_hi TEXT,
    description TEXT,
    r2_content_path TEXT,                  -- path to JSON in R2
    r2_simulation_path TEXT,               -- path to HTML in R2
    estimated_duration INTEGER,            -- minutes
    difficulty TEXT DEFAULT 'medium',      -- easy, medium, hard
    is_published BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(subject_id, chapter_number)
);

CREATE INDEX idx_chapters_subject ON chapters(subject_id);

-- ============================================
-- USER PROGRESS
-- ============================================
CREATE TABLE IF NOT EXISTS user_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    chapter_id UUID REFERENCES chapters(id) ON DELETE CASCADE,
    status TEXT DEFAULT 'not_started',     -- not_started, in_progress, completed
    score INTEGER DEFAULT 0,
    time_spent INTEGER DEFAULT 0,          -- seconds
    last_accessed_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, chapter_id)
);

CREATE INDEX idx_progress_user ON user_progress(user_id);
CREATE INDEX idx_progress_chapter ON user_progress(chapter_id);

-- ============================================
-- CHAT SESSIONS
-- ============================================
CREATE TABLE IF NOT EXISTS chat_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    chapter_id UUID REFERENCES chapters(id) ON DELETE SET NULL,
    title TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_chat_sessions_user ON chat_sessions(user_id);

-- ============================================
-- CHAT MESSAGES
-- ============================================
CREATE TABLE IF NOT EXISTS chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,
    role TEXT NOT NULL,                    -- user, assistant
    content TEXT NOT NULL,
    input_type TEXT DEFAULT 'text',        -- text, voice, image
    output_type TEXT DEFAULT 'text',       -- text, voice
    credits_used INTEGER DEFAULT 1,
    tokens_used INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_messages_session ON chat_messages(session_id);
CREATE INDEX idx_messages_created ON chat_messages(created_at);

-- ============================================
-- EMBEDDINGS (for RAG)
-- ============================================
CREATE TABLE IF NOT EXISTS embeddings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chapter_id UUID REFERENCES chapters(id) ON DELETE CASCADE,
    chunk_index INTEGER NOT NULL,
    chunk_type TEXT DEFAULT 'concept',     -- concept, definition, qa, formula
    content TEXT NOT NULL,
    embedding vector(768),                 -- Gemini embedding dimension
    r2_json_path TEXT,                     -- pointer to full content in R2
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(chapter_id, chunk_index)
);

CREATE INDEX idx_embeddings_chapter ON embeddings(chapter_id);

-- Create vector similarity search index (IVFFlat for better performance)
CREATE INDEX idx_embeddings_vector ON embeddings
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);

-- ============================================
-- CREDIT TRANSACTIONS
-- ============================================
CREATE TABLE IF NOT EXISTS credit_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL,               -- positive = add, negative = use
    transaction_type TEXT NOT NULL,        -- daily_reset, chat, purchase, bonus
    description TEXT,
    reference_id UUID,                     -- chat_message_id or payment_id
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_credits_user ON credit_transactions(user_id);
CREATE INDEX idx_credits_created ON credit_transactions(created_at);

-- ============================================
-- SUBSCRIPTIONS
-- ============================================
CREATE TABLE IF NOT EXISTS subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    tier TEXT NOT NULL,
    status TEXT DEFAULT 'active',          -- active, cancelled, expired
    starts_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    expires_at TIMESTAMP WITH TIME ZONE,
    payment_provider TEXT,                 -- phonepe, razorpay
    payment_id TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_subscriptions_user ON subscriptions(user_id);

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Function to search similar embeddings
CREATE OR REPLACE FUNCTION match_embeddings(
    query_embedding vector(768),
    match_threshold float DEFAULT 0.7,
    match_count int DEFAULT 5,
    filter_chapter_id uuid DEFAULT NULL
)
RETURNS TABLE (
    id uuid,
    chapter_id uuid,
    chunk_index integer,
    content text,
    similarity float
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.id,
        e.chapter_id,
        e.chunk_index,
        e.content,
        1 - (e.embedding <=> query_embedding) AS similarity
    FROM embeddings e
    WHERE
        (filter_chapter_id IS NULL OR e.chapter_id = filter_chapter_id)
        AND 1 - (e.embedding <=> query_embedding) > match_threshold
    ORDER BY e.embedding <=> query_embedding
    LIMIT match_count;
END;
$$;

-- Function to reset daily credits
CREATE OR REPLACE FUNCTION reset_daily_credits()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE users
    SET
        daily_credits = CASE
            WHEN subscription_tier = 'free' THEN 5
            WHEN subscription_tier = 'class5-6' THEN 15
            WHEN subscription_tier = 'class7-8-9' THEN 25
            WHEN subscription_tier = 'class10' THEN 35
            ELSE 5
        END,
        credits_reset_at = NOW()
    WHERE credits_reset_at IS NULL
       OR credits_reset_at < NOW() - INTERVAL '1 day';
END;
$$;

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE credit_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;

-- Users can only see their own data
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid()::text = firebase_uid);

CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid()::text = firebase_uid);

-- Progress policies
CREATE POLICY "Users can view own progress" ON user_progress
    FOR SELECT USING (user_id IN (SELECT id FROM users WHERE firebase_uid = auth.uid()::text));

CREATE POLICY "Users can update own progress" ON user_progress
    FOR ALL USING (user_id IN (SELECT id FROM users WHERE firebase_uid = auth.uid()::text));

-- Chat policies
CREATE POLICY "Users can view own chat sessions" ON chat_sessions
    FOR SELECT USING (user_id IN (SELECT id FROM users WHERE firebase_uid = auth.uid()::text));

CREATE POLICY "Users can manage own chat sessions" ON chat_sessions
    FOR ALL USING (user_id IN (SELECT id FROM users WHERE firebase_uid = auth.uid()::text));

CREATE POLICY "Users can view own messages" ON chat_messages
    FOR SELECT USING (session_id IN (
        SELECT id FROM chat_sessions WHERE user_id IN (
            SELECT id FROM users WHERE firebase_uid = auth.uid()::text
        )
    ));

-- Public read access for content tables
CREATE POLICY "Anyone can view subjects" ON subjects FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "Anyone can view chapters" ON chapters FOR SELECT TO anon, authenticated USING (is_published = true);
CREATE POLICY "Anyone can view embeddings" ON embeddings FOR SELECT TO anon, authenticated USING (true);

-- ============================================
-- TRIGGERS
-- ============================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tr_chapters_updated_at
    BEFORE UPDATE ON chapters
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tr_progress_updated_at
    BEFORE UPDATE ON user_progress
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tr_chat_sessions_updated_at
    BEFORE UPDATE ON chat_sessions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================
-- GRANT PERMISSIONS
-- ============================================

-- Grant access to authenticated users
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON users, user_progress, chat_sessions, chat_messages, credit_transactions, subscriptions TO authenticated;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO authenticated;
