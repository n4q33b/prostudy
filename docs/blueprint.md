# AI Learning App - Strategic Blueprint

> **Version:** 1.3 | **Date:** January 2026
> **Philosophy:** Launch fast with free tiers → Scale only when needed
> **Phase 1:** Maharashtra State Board | **Phase 2:** CBSE Board

---

## 🎯 Product Overview

### What We're Building
An interactive learning app that transforms school textbooks into visual simulations with an AI tutor. Students learn through interactive animations, ask questions via text/voice/image, and get AI-powered answers from their textbook content.

### Core Features
1. **Interactive Simulations** - HTML/CSS/JS animations for each chapter
2. **AI Chat Tutor** - RAG-powered Q&A from textbook content
3. **Multimodal Input** - Text, voice, and image questions (native Gemini)
4. **Voice Replies** - AI speaks answers back (native Gemini)
5. **Multi-Board Support** - Maharashtra State Board (Phase 1), CBSE (Phase 2)
6. **Multi-Medium Support** - Marathi, Hindi, English, Urdu, Semi-English
7. **Progress Tracking** - Track completed chapters and scores
8. **Syllabus Versioning** - Year-based content management

### Target Users
- **Primary:** Students (Class 5-10)
- **Secondary:** Parents monitoring progress
- **Tertiary:** Teachers assigning content

---

## 🚀 Phased Rollout Strategy

### Phase 1: Maharashtra State Board (Launch)

| Item | Details |
|------|---------|
| **Board** | Maharashtra State Board |
| **Classes** | 5-10 |
| **Textbooks** | Bal Bharti (from ebalbharati.in) |
| **Mediums** | Marathi, Hindi, English, Urdu, Semi-English |
| **Content** | ~2,500 chapters |
| **Licensing** | Balbharati commercial license (apply + pay fee on ebalbharati.in) |
| **Timeline** | Month 1-3 |
| **Target** | Maharashtra students |

**Licensing Note:** Balbharati has a clear commercial licensing process. Apply on ebalbharati.in, pay the license fee, and get permission to reference book names, chapter names, and syllabus structure. All simulations, Q&A, and explanations are our original content. License renewed annually.

### Phase 2: CBSE Board (Expansion)

| Item | Details |
|------|---------|
| **Board** | CBSE |
| **Classes** | 5-10 |
| **Textbooks** | NCERT (reference CBSE board, not NCERT brand) |
| **Mediums** | English, Hindi |
| **Content** | ~870 chapters (435 per language) |
| **Licensing** | Reference "CBSE Board" (public board, no license needed) |
| **Timeline** | Month 4-6 (after Maharashtra validates) |
| **Target** | All India (20M+ CBSE students) |

**Content Strategy for CBSE:**
- All content (simulations, Q&A, explanations) is 100% original
- Reference as "CBSE Class 7 — Science — Photosynthesis" (board reference, not NCERT)
- 60-70% of Science/Maths simulations reusable from Maharashtra
- Optionally send proposal to NCERT (pd.ncert@nic.in) for formal permission to use NCERT branding — not a blocker
- If NCERT grants license: upgrade to "NCERT" branding
- If no reply: continue with "CBSE" branding (perfectly legal)

### Phase 3: Scale (Future)

| Board | Potential |
|-------|-----------|
| ICSE | ~2 million students |
| Karnataka State Board | ~8 million students |
| Tamil Nadu State Board | ~10 million students |
| Other State Boards | 200M+ students across India |

---

## 🏛️ Tech Stack

### Architecture Overview

| Component | Service | Why |
|-----------|---------|-----|
| **Auth** | Firebase Auth | Free unlimited, best Flutter SDK, Google/Phone sign-in |
| **Database** | Supabase (PostgreSQL) | 500MB free, SQL power, real-time |
| **Vector Search** | Supabase pgvector | Built-in, no separate vector DB |
| **File Storage** | Cloudflare R2 | 10GB free, ZERO egress fees |
| **CDN** | Cloudflare | Free, automatic with R2 |
| **LLM** | Gemini 2.5 Flash | Native multimodal, best Indic language support |
| **Frontend** | Flutter | Single codebase iOS + Android |
| **Simulations** | HTML/CSS/JS | Claude Code generates fast, clean, lightweight |

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                     FLUTTER APP                         │
└──────────┬───────────────────┬───────────────┬──────────┘
           │                   │               │
           ▼                   ▼               ▼
┌──────────────────┐ ┌─────────────────┐ ┌────────────────┐
│  FIREBASE AUTH   │ │    SUPABASE     │ │ CLOUDFLARE R2  │
│     (Free)       │ │    (Free)       │ │    (Free)      │
│                  │ │                 │ │                │
│ • Google Sign-in │ │ • User data     │ │ • JSON files   │
│ • Phone Auth     │ │ • Progress      │ │   (knowledge)  │
│ • Email Auth     │ │ • Chat history  │ │ • Simulations  │
│                  │ │ • Embeddings    │ │   (HTML/JS)    │
│                  │ │   (pgvector)    │ │ • Images       │
└──────────────────┘ └────────┬────────┘ └────────────────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │   GEMINI API    │
                    │                 │
                    │ • Embeddings    │
                    │ • Chat (LLM)   │
                    │ • Voice I/O    │
                    │ • Image input  │
                    └─────────────────┘
```

---

## 💾 Data Architecture (Hybrid Storage)

### What Goes Where

| Data Type | Storage | Why |
|-----------|---------|-----|
| JSON Knowledge Files (Q&A) | Cloudflare R2 | Static content, CDN, keeps DB small |
| HTML Simulations | Cloudflare R2 | Large files, zero egress |
| Images/Assets | Cloudflare R2 | CDN optimized |
| Embeddings + Pointers | Supabase pgvector | Vector search requires DB |
| User Profiles | Supabase | Relational queries |
| Progress Data | Supabase | User-specific |
| Chat History | Supabase | Searchable, per-user |
| Syllabus Metadata | Supabase | Version control |

### Content Volume

**Phase 1 — Maharashtra:**

| Item | Count | Size |
|------|-------|------|
| Chapters | ~2,500 | ~65MB JSON |
| Q&A per chapter | 30-40 avg | 75,000+ total |
| Simulations | ~2,500 | ~100MB HTML |
| Embeddings | ~75,000 | ~225MB |

**Phase 2 — CBSE (additional):**

| Item | Count | Size |
|------|-------|------|
| Chapters | ~870 | ~22MB JSON |
| Q&A per chapter | 30-40 avg | 26,000+ total |
| New simulations | ~300 (30% new) | ~12MB HTML |
| Reused simulations | ~570 (70% from Maharashtra) | 0MB (shared) |
| Embeddings | ~26,000 | ~78MB |

### Free Tier Usage (Both Phases Combined)

| Service | Free Limit | Phase 1 Usage | Phase 1+2 Usage | Status |
|---------|------------|---------------|-----------------|--------|
| Cloudflare R2 | 10GB | ~215MB | ~315MB | ✅ 3% used |
| Supabase | 500MB | ~150MB | ~250MB | ✅ 50% used |
| Firebase Auth | Unlimited | Any | Any | ✅ Always free |

---

## 📁 Storage Structure (Cloudflare R2)

```
r2-bucket/
│
├── content/
│   ├── 2026/
│   │   ├── maharashtra/                    ← Phase 1
│   │   │   ├── marathi/
│   │   │   │   ├── class7/
│   │   │   │   │   ├── science/
│   │   │   │   │   │   ├── ch01.json
│   │   │   │   │   │   └── ...
│   │   │   │   │   ├── maths/
│   │   │   │   │   └── ...
│   │   │   │   └── class8/
│   │   │   ├── hindi/
│   │   │   ├── english/
│   │   │   ├── urdu/
│   │   │   └── semi-english/
│   │   │
│   │   └── cbse/                           ← Phase 2
│   │       ├── english/
│   │       │   ├── class7/
│   │       │   │   ├── science/
│   │       │   │   └── ...
│   │       │   └── ...
│   │       └── hindi/
│   │
│   ├── 2025/                               ← Archived
│   └── 2027/                               ← Draft (next year)
│
├── simulations/
│   ├── shared/                             ← Reusable across boards
│   │   ├── photosynthesis.html
│   │   ├── water_cycle.html
│   │   └── periodic_table.html
│   ├── maharashtra/                        ← Board-specific
│   └── cbse/
│
└── assets/
    ├── icons/
    ├── images/
    └── audio/
```

---

## 🤖 RAG System Design (Hybrid Approach)

### How It Works

```
Student asks question
        │
        ▼
Step 1: Embed question (Gemini Embedding API)
        │
        ▼
Step 2: Vector search in Supabase pgvector
        → Returns: chapter_id + chunk_indices (NOT full content)
        │
        ▼
Step 3: Fetch JSON from Cloudflare R2 (single HTTP call)
        → GET /content/2026/{board}/{medium}/{class}/{subject}/ch{N}.json
        │
        ▼
Step 4: Extract relevant Q&As using chunk indices
        │
        ▼
Step 5: Send context + question to Gemini 2.5 Flash
        │
        ▼
Step 6: Return answer (text or voice)
```

### System Prompt Strategy

```
Role: School teacher for {board} board
Language: Match student's medium
Style: Encouraging, patient, clear
Constraint: Answer ONLY from provided context
Format: Step-by-step for math/science
Board-aware: Use terminology matching student's board
```

### Chunking Strategy

| Content Type | Chunk Size | Overlap |
|--------------|------------|---------|
| Concepts | 200-400 words | 50 words |
| Definitions | Single definition | None |
| Q&A pairs | Question + Answer | None |
| Formulas | Formula + explanation | None |
| Stories | Scene/paragraph | 1 sentence |

---

## 📚 Syllabus Versioning Strategy

### Year-Based Versioning

Each academic year has its own folder in R2. Only one version is "active" at a time.

**Status Flow:** draft → active → archived

### Supabase Versioning Tables

**syllabus_versions** — tracks which year is active per board
**chapters_metadata** — tracks last_updated, change_type per chapter
**chapter_changes** — tracks which chunks were affected, embedding status

### Update Workflows

| Scenario | Action |
|----------|--------|
| Minor edit (typo) | Update JSON in R2, update timestamp in Supabase |
| Q&A changes | Update JSON, regenerate affected embeddings only |
| New academic year | Create new year folder, copy + modify, regenerate all embeddings |
| Syllabus switch | Flip status flag in DB — no app update needed |

### Students Mid-Year

- enrolled_year stored in user profile
- Students finish current year content even after syllabus switch
- Archive remains accessible via year parameter

### Cost of Updates

| Item | Cost |
|------|------|
| Full embedding regeneration (per board) | ~$1.50 |
| Partial update (10% chapters) | ~$0.15 |
| R2 storage (extra year) | Negligible (within free tier) |

---

## 💰 Monetization & Pricing

### Gemini 2.5 Flash — Native Multimodal (One API = Everything)

| Feature | Built Into Gemini | Separate API? |
|---------|-------------------|---------------|
| Text Chat | ✅ | ❌ No |
| Voice Input | ✅ | ❌ No |
| Voice Output | ✅ | ❌ No |
| Image Input | ✅ | ❌ No |

### Gemini API Costs

| Input Type | Cost per 1M Tokens |
|------------|-------------------|
| Text | $0.15 |
| Audio | $1.00 |
| Image | $0.15 (~1000 tokens/image) |

| Output Type | Cost per 1M Tokens |
|-------------|-------------------|
| Text | $0.60 |
| Audio | $4.00 |

### Real Cost Per Chat Type

| Chat Type | Total Cost | In ₹ |
|-----------|------------|------|
| Text → Text | ₹0.025 | Cheapest |
| Audio → Text | ₹0.065 | ~2.5x text |
| Audio → Audio | ₹0.15 | ~6x text |
| Image → Text | ₹0.095 | ~4x text |
| Image → Audio | ₹0.18 | ~7x text |

### Credit System

| Action | Credits | Actual Cost |
|--------|---------|-------------|
| Text → Text | 1 | ₹0.025 |
| Voice → Text | 2 | ₹0.065 |
| Voice → Voice | 5 | ₹0.15 |
| Image → Text | 3 | ₹0.095 |
| Image → Voice | 6 | ₹0.18 |

### Subscription Tiers

| Tier | Price | Daily Credits | Max Cost/Month | Margin |
|------|-------|---------------|----------------|--------|
| Free Trial | ₹0 | 5 | ₹1.50 (7 days) | - |
| Class 5-6 | ₹99/mo | 15 | ₹18 | **82%** |
| Class 7-8-9 | ₹149/mo | 25 | ₹30 | **80%** |
| Class 10 | ₹199/mo | 35 | ₹42 | **79%** |
| School (per student) | ₹83/mo (₹1000/yr) | 15 | ₹18 | **78%** |

**Same pricing applies to all boards.**

### Top-Up Packages

| Package | Price | Credits | Your Cost | Margin |
|---------|-------|---------|-----------|--------|
| +25 credits | ₹19 | 25 | ₹1.50 | **92%** |
| +60 credits | ₹39 | 60 | ₹3.60 | **91%** |
| +150 credits | ₹79 | 150 | ₹9.00 | **89%** |

### Chat UI with Credits

```
┌─────────────────────────────────────────┐
│  💬 AI Tutor            22/25 credits   │
├─────────────────────────────────────────┤
│                                         │
│  [Chat history...]                      │
│                                         │
├─────────────────────────────────────────┤
│                                         │
│  [Type your question...         ]       │
│                                         │
│  ┌─────┐  ┌─────┐  ┌──────────────┐    │
│  │ 📷  │  │ 🎤  │  │   Send ➤    │    │
│  │ +3  │  │ +2  │  │     1       │    │
│  └─────┘  └─────┘  └──────────────┘    │
│                                         │
│  🔊 Voice reply (+4 extra)              │
└─────────────────────────────────────────┘
```

User sees: Text = 1 credit, Image = +3, Voice input = +2, Voice reply = +4

---

## 📊 Cost Projections

### Infrastructure Costs by Scale

| DAU | Supabase | R2 | Firebase Auth | Gemini | Total |
|-----|----------|-----|---------------|--------|-------|
| 100 | $0 | $0 | $0 | ~$15 | **$15** |
| 500 | $0 | $0 | $0 | ~$75 | **$75** |
| 1,000 | $0 | $0 | $0 | ~$150 | **$150** |
| 3,000 | $0-25 | $0 | $0 | ~$450 | **$450-475** |
| 5,000 | $25 | $0 | $0 | ~$750 | **$775** |

### When Free Tier Ends

| Service | Trigger | New Cost |
|---------|---------|----------|
| Supabase | >500MB database | $25/mo (Pro plan) |
| R2 | >10GB storage | $0.015/GB/mo |
| Firebase Auth | Never | $0 |

### One-Time Costs

| Item | Cost |
|------|------|
| Gemini Embeddings (Maharashtra) | ~$1.50 |
| Gemini Embeddings (CBSE) | ~$0.50 |
| Balbharati License | As per their fee structure |
| Domain name | ~$12/year |
| Apple Developer Account | $99/year |
| Google Play Developer | $25 (one-time) |

### Revenue Projections

| Metric | Phase 1 (Maharashtra) | Phase 1+2 (Both) |
|--------|----------------------|-------------------|
| Addressable students | ~15 million | ~27 million |
| Realistic DAU (0.1%) | 15,000 | 27,000 |
| Paid conversion (5%) | 750 | 1,350 |
| Avg revenue/user | ₹149/mo | ₹149/mo |
| **Monthly revenue** | **₹1.1 lakh** | **₹2 lakh** |
| Top-up revenue (10% users) | +₹15K | +₹27K |

---

## 📅 Launch Timeline

### Phase 1: Maharashtra State Board

| Week | Tasks |
|------|-------|
| 1-2 | Firebase Auth + Supabase + R2 setup, Balbharati license |
| 3-4 | Content extraction: Class 7 Science + Maths (Marathi) |
| 5-6 | Embedding generation, upload to Supabase + R2 |
| 7-8 | Flutter app development, RAG integration |
| 9 | Internal testing, bug fixes |
| 10 | Beta test with 20-50 students |
| 11 | App store submissions |
| 12 | Launch 🚀 |

### Phase 2: CBSE Board (Month 4-6 after launch)

| Week | Tasks |
|------|-------|
| 1 | Add board selection in onboarding |
| 2-3 | Create original CBSE content (English), reuse simulations |
| 4 | Generate CBSE embeddings, upload |
| 5 | Add Hindi medium |
| 6 | Test + launch CBSE support |

---

## 📱 App Structure

### Onboarding Flow

```
Splash → Select Board → Select Class → Select Medium → Signup/Login → Home
```

### User Profile

- board (maharashtra / cbse)
- class (5-10)
- medium (marathi / hindi / english / urdu / semi-english)
- enrolled_year (2026)
- subscription_tier
- daily_credits_remaining

### Screen Flow

```
Home (Subject Grid)
    → Chapter List (with progress indicators)
        → Simulation Screen (WebView + Chat FAB)
            → Chat Modal (AI Tutor with credits display)
```

---

## 📈 Success Metrics

| Metric | Month 1 | Month 3 | Month 6 |
|--------|---------|---------|---------|
| Downloads | 1,000 | 10,000 | 25,000 |
| DAU | 100 | 1,000 | 3,000 |
| DAU/MAU ratio | 20% | 25% | 30% |
| Avg credits used/user/day | 5 | 8 | 10 |
| Retention (D7) | 20% | 28% | 35% |
| Paid conversion | 2% | 4% | 5% |
| App rating | 4.0+ | 4.2+ | 4.5+ |

---

## ⚠️ Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Gemini API downtime | Cache recent answers, offline message |
| Supabase outage | Local caching of critical data |
| R2 unavailable | Simulations bundled as fallback |
| Syllabus change mid-year | Year-based versioning, enrollment tracking |
| Cost overrun | Spend caps, usage alerts |
| Content inaccuracy | Multi-step review before publish |
| NCERT copyright issues | Reference "CBSE Board" not "NCERT" |
| Low adoption | School partnerships, teacher referrals |
| Competition (Byju's, PW) | 10x cheaper + AI tutor + interactive simulations |

---

## 🏆 Competitive Edge

| Competitor | Price | AI Tutor? | Simulations? | Our Advantage |
|------------|-------|-----------|--------------|---------------|
| Byju's | ₹5000+/yr | ❌ | Videos only | 10x cheaper, AI powered |
| Physics Wallah | ₹500-2000 | ❌ | Videos only | Interactive, multimodal AI |
| Doubtnut | Free (ads) | Basic | ❌ | Better simulations, no ads |
| Khan Academy | Free | ❌ | Some | Indic languages, board-specific |
| **Our App** | **₹99-199** | **✅ Multimodal** | **✅ Interactive** | **Affordable + AI + visual** |

---

## 🔑 Key Decisions Summary

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Auth | Firebase Auth | Free, best Flutter SDK |
| Database | Supabase PostgreSQL | pgvector built-in, generous free tier |
| Vector DB | Supabase pgvector | No separate service needed |
| File Storage | Cloudflare R2 | Zero egress, 10GB free |
| Knowledge Base | JSON files in R2 | Keeps Supabase small, CDN delivery |
| Embeddings | Supabase (pointers to R2) | Hybrid = best of both |
| LLM | Gemini 2.5 Flash | Native multimodal, Indic languages |
| Simulations | HTML/CSS/JS | Claude Code generates fast and clean |
| Versioning | Year-based R2 folders | Easy updates, no app update needed |
| Frontend | Flutter | Single codebase |
| Monetization | Credit-based | Fair multimodal pricing, 78-82% margins |
| Phase 1 Board | Maharashtra State Board | Home market, Balbharati license available |
| Phase 2 Board | CBSE | 2x market, 70% simulation reuse |
| CBSE Licensing | Reference "CBSE Board" | Public board, no license needed |

---

## ✅ Checklist Before Starting

### Phase 1 (Maharashtra)
- [ ] Firebase project created
- [ ] Supabase project + pgvector extension enabled
- [ ] Cloudflare account + R2 bucket + custom domain
- [ ] Gemini API key obtained
- [ ] Balbharati license applied and obtained
- [ ] R2 folder structure created
- [ ] Supabase tables created
- [ ] Domain name registered
- [ ] Intern briefed with extraction prompts
- [ ] Flutter dev environment ready
- [ ] Sample Bal Bharti PDFs downloaded from ebalbharati.in
- [ ] Apple Developer account
- [ ] Google Play Developer account

### Phase 2 (CBSE) — After Maharashtra Launch
- [ ] Add board selection to onboarding
- [ ] Create CBSE content folders in R2
- [ ] Identify reusable simulations (tag as shared)
- [ ] Create original CBSE Q&A content
- [ ] Generate CBSE embeddings
- [ ] Optional: Send licensing proposal to NCERT (pd.ncert@nic.in)
- [ ] Test and launch

---

*Document maintained by: NSTAR Solution LLP*
*Last updated: January 2026*
*Next review: After reaching 1000 DAU*
