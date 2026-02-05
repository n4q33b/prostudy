# ProStudy - Context (Single Source of Truth)

> **Version:** 1.0 | **Last Updated:** February 2026
> **Domain:** prostudy.app | **Phase:** Infrastructure Setup

---

## 1. Project Overview

**Name:** ProStudy
**Goal:** AI-powered learning app transforming textbooks into visual simulations with AI tutor
**Target:** Maharashtra State Board (Phase 1), CBSE (Phase 2)
**Philosophy:** "Launch fast with free tiers → Scale only when needed"

### Core Features
- Interactive HTML/CSS/JS simulations for each chapter
- AI Chat Tutor (RAG-powered from textbook content)
- Multimodal input (text, voice, image) via Gemini
- Multi-board & multi-language support
- Credit-based monetization (78-82% margins)

---

## 2. Current Status

| Milestone | Status |
|-----------|--------|
| Project planning | ✅ Complete |
| Firebase setup | ✅ Apps created |
| Supabase setup | ✅ Active |
| Cloudflare R2 | ✅ Bucket created |
| Flutter app | 🔲 Not started |
| Content creation | 🔲 Not started |

**Next Action:** Enable Firebase Auth and create Supabase schema

---

## 3. Credentials & Services

### Firebase (prostudy-51534)

| Key | Value |
|-----|-------|
| Project ID | `prostudy-51534` |
| Project Number | `396820470969` |
| Auth Domain | `prostudy-51534.firebaseapp.com` |
| Storage Bucket | `prostudy-51534.firebasestorage.app` |

**Web App:**
```
App ID: 1:396820470969:web:3e221df1f1f7150f604f68
API Key: AIzaSyCjgU33EUN6U_LnqEOFjkFlP2RQYA893Js
Messaging Sender ID: 396820470969
Measurement ID: G-J2BE3J3ZNG
```

**Android App:**
```
App ID: 1:396820470969:android:3d7c5fccbc28deac604f68
Package: com.nstar.prostudy
```

**iOS App:**
```
App ID: 1:396820470969:ios:990e91f3f4bd5270604f68
Bundle ID: com.nstar.prostudy
```

### Supabase (prostudy)

| Key | Value |
|-----|-------|
| Project Ref | `aixjdhdbyvicrwqilsyw` |
| Region | South Asia (Mumbai) |
| URL | `https://aixjdhdbyvicrwqilsyw.supabase.co` |
| Status | **ACTIVE** |
| DB Password | `ProStudy2026Secure!` |
| Anon Key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpeGpkaGRieXZpY3J3cWlsc3l3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAzMDMyNDEsImV4cCI6MjA4NTg3OTI0MX0.XzsECtsTz9KBxexfWQdf31XIIxOHPA41kvB-DDYp3ko` |
| Service Key | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFpeGpkaGRieXZpY3J3cWlsc3l3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MDMwMzI0MSwiZXhwIjoyMDg1ODc5MjQxfQ.UAfLFKek-wcQ_aEZ37ufmxQj_N9P-z3zHoaToPAHOHY` |

**Dashboard:** https://supabase.com/dashboard/project/aixjdhdbyvicrwqilsyw

### Cloudflare R2

| Key | Value |
|-----|-------|
| Account ID | `a08932bc7e89ae237c8bac43d11471f6` |
| Bucket | `prostudy-content` |
| Domain | `prostudy.app` |

**R2 Folder Structure:**
```
prostudy-content/
├── content/
│   └── 2026/
│       ├── maharashtra/
│       └── cbse/
├── simulations/
│   └── shared/
└── assets/
```

### Gemini API

| Key | Value |
|-----|-------|
| API Key | `AIzaSyD2rWrPBUTcfQBz4KUbkuLIy1ZxpucLG0Q` |
| Model | `gemini-2.5-flash` |

### GitHub

| Key | Value |
|-----|-------|
| Repo | https://github.com/n4q33b/prostudy |
| Username | `n4q33b` |

---

## 4. Tech Stack

| Component | Service | Free Tier | Status |
|-----------|---------|-----------|--------|
| Auth | Firebase Auth | Unlimited | ✅ Ready |
| Database | Supabase PostgreSQL | 500MB | ✅ Ready |
| Vector Search | Supabase pgvector | Built-in | ✅ Ready |
| File Storage | Cloudflare R2 | 10GB | ✅ Ready |
| CDN | Cloudflare | Free | ✅ Ready |
| LLM | Gemini 2.5 Flash | Pay-per-use | ✅ Key ready |
| Frontend | Flutter | - | 🔲 Pending |
| Simulations | HTML/CSS/JS | - | 🔲 Pending |

---

## 5. Project Structure

```
prostudy/
├── app/                      # Flutter mobile app
│   ├── lib/
│   ├── android/
│   ├── ios/
│   └── pubspec.yaml
├── content/                  # Content generation
│   ├── extractors/          # PDF/textbook extractors
│   ├── generators/          # Q&A generation scripts
│   └── embeddings/          # Embedding generation
├── infrastructure/          # IaC configs
│   ├── supabase/           # Supabase migrations
│   ├── firebase/           # Firebase configs
│   └── cloudflare/         # R2/Workers configs
├── simulations/            # HTML/CSS/JS simulations
│   ├── shared/             # Reusable across boards
│   ├── maharashtra/        # Board-specific
│   └── cbse/
├── scripts/                # Utility scripts
├── docs/                   # Documentation
│   └── blueprint.md        # Detailed specifications
└── context.md              # This file (SSOT)
```

---

## 6. Database Schema (Supabase)

### Tables (to be created)

```sql
-- Users (synced from Firebase Auth)
users (
  id UUID PRIMARY KEY,
  firebase_uid TEXT UNIQUE,
  board TEXT,           -- maharashtra, cbse
  class INTEGER,        -- 5-10
  medium TEXT,          -- marathi, hindi, english, urdu, semi-english
  enrolled_year INTEGER,
  subscription_tier TEXT,
  daily_credits INTEGER,
  created_at TIMESTAMP
)

-- Progress tracking
user_progress (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users,
  chapter_id TEXT,
  status TEXT,          -- not_started, in_progress, completed
  score INTEGER,
  time_spent INTEGER,
  updated_at TIMESTAMP
)

-- Chat history
chat_sessions (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users,
  chapter_id TEXT,
  created_at TIMESTAMP
)

chat_messages (
  id UUID PRIMARY KEY,
  session_id UUID REFERENCES chat_sessions,
  role TEXT,            -- user, assistant
  content TEXT,
  credits_used INTEGER,
  created_at TIMESTAMP
)

-- Embeddings for RAG
embeddings (
  id UUID PRIMARY KEY,
  chapter_id TEXT,
  chunk_index INTEGER,
  content TEXT,
  embedding VECTOR(768),
  r2_path TEXT          -- pointer to full JSON in R2
)
```

---

## 7. Active Tasks

- [ ] Enable Firebase Auth (Google, Phone)
- [ ] Create Supabase schema with pgvector
- [ ] Initialize Flutter project
- [ ] Copy blueprint.md to docs/
- [ ] Apply for Balbharati license
- [ ] Set up R2 public access / custom domain

---

## 8. Timeline (12 weeks)

| Week | Tasks |
|------|-------|
| 1-2 | Infrastructure setup, Balbharati license |
| 3-4 | Content extraction: Class 7 Science + Maths (Marathi) |
| 5-6 | Embedding generation, upload to Supabase + R2 |
| 7-8 | Flutter app development, RAG integration |
| 9 | Internal testing, bug fixes |
| 10 | Beta test with 20-50 students |
| 11 | App store submissions |
| 12 | Launch |

---

## 9. Important Links

| Resource | URL |
|----------|-----|
| Firebase Console | https://console.firebase.google.com/project/prostudy-51534 |
| Supabase Dashboard | https://supabase.com/dashboard/project/aixjdhdbyvicrwqilsyw |
| Cloudflare Dashboard | https://dash.cloudflare.com |
| GitHub Repo | https://github.com/n4q33b/prostudy |
| Live Domain | https://prostudy.app |
| Balbharati Portal | https://ebalbharati.in |

---

## 10. Notes for AI Assistants

### Getting Started
1. **Always read this file first** when starting a new session
2. Check current status and active tasks
3. Reference `docs/blueprint.md` for detailed specifications

### Making Changes
- Update this file after any significant changes
- Keep credentials section current
- Mark tasks complete when done

### Security
- These credentials are for development
- Rotate keys before production launch
- Never commit `.env` files with real secrets

---

*Maintained by: NSTAR Solution LLP*
*Reference: [blueprint.md](./docs/blueprint.md) for complete specifications*
