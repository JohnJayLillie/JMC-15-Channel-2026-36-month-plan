# Video Producer M15 - 15-Channel Documentary Production System

**Version:** 4.0  
**Updated:** January 2026  
**Major Change:** API Image Library integration for automated prompt generation  
Production framework for 754 subjects, 2,262 videos across 15 channels.

---

## THE 15 CHANNELS (M15)

| # | Channel | Code | Subjects | RPM | Structure |
|---|---------|------|----------|-----|-----------|
| 1 | Financial Vice | FV | 54 | $20-40 | THE RISE → THE FALL → THE RECKONING |
| 2 | Shadow Fortunes | SF | 50 | $18-35 | THE SYSTEM → THE INVESTIGATION → THE IMPLICATIONS |
| 3 | Shadow Capitalism | SC | 50 | $18-35 | THE MECHANISM → WHO USES IT → THE IMPLICATIONS |
| 4 | USA Money Flow | USM | 50 | $15-30 | THE SPENDING → THE BENEFICIARIES → THE ACCOUNTABILITY |
| 5 | Crypto Forensic Files | CFF | 50 | $25-45 | THE PROMISE → THE FRAUD → THE COLLAPSE |
| 6 | Healthcare Heist | HH | 50 | $18-35 | THE SCHEME → THE VICTIMS → THE RECKONING |
| 7 | Real Estate Rackets | RER | 50 | $15-30 | THE DEAL → THE SCHEME → THE FALLOUT |
| 8 | Political Money Flow | PMF | 50 | $15-28 | THE POWER → THE MONEY → THE CONSEQUENCES |
| 9 | Tax Crimes | TC | 50 | $20-38 | THE EVASION → THE INVESTIGATION → THE PROSECUTION |
| 10 | Wall Street Predators | WSP | 50 | $18-35 | THE SCHEME → THE VICTIMS → THE FALLOUT |
| 11 | Bankruptcy Billions | BB | 50 | $15-28 | THE EMPIRE → THE COLLAPSE → THE AFTERMATH |
| 12 | Cartel Capital | CC | 50 | $18-32 | THE OPERATION → THE MONEY → THE TAKEDOWN |
| 13 | Early Intel | EI | 50 | $15-28 | THE VISION → THE WARNING SIGNS → THE COLLAPSE |
| 14 | Startup Graveyard | SG | 50 | $20-35 | THE HYPE → THE REALITY → THE DEATH |
| 15 | Legal Billions | LB | 50 | $18-30 | THE HARM → THE FIGHT → THE VERDICT |

---

## SINGLE SUBJECT WORKFLOW

**Each run generates 3 documents for ONE subject:**

1. Voice Over Script (.docx) — Teleprompter-ready narration
2. Image Gathering Guide (.md) — Sourcing roadmap with DALL-E prompts **AUTO-POPULATED FROM API LIBRARY**
3. Production Script (.md) — Master editor document with full timing

**Invocation:** `Generate [SUBJECT_ID]` or `[Channel]: [Subject Name]`

**Examples:**
```
Generate CFF001
Generate FV001
Financial Vice: Bernie Madoff
Crypto Forensic Files: Sam Bankman-Fried
```

---

## API IMAGE LIBRARY INTEGRATION

### Overview

When generating documents, the system automatically:
1. **Queries** `M15_Image_Library_API.csv` for the subject's channel
2. **Pulls** relevant DALL-E prompts based on Priority (HIGH/MEDIUM/LOW)
3. **Includes** Creative Commons alternatives where appropriate
4. **Populates** Image Gathering Guide with ready-to-use prompts
5. **Optimizes** cost by prioritizing HIGH priority DALL-E, MEDIUM/LOW from CC

### Current State: Semi-Automated

**What's Automated (v4):**
- ✅ CSV query by channel
- ✅ Prompt population in Image Gathering Guide
- ✅ Priority sorting (HIGH → MEDIUM → LOW)
- ✅ Filename generation with systematic naming
- ✅ CC search terms provided

**What's Manual (Current):**
- 📋 Folder creation: `mkdir -p Images/[SUBJECT]/CategoryB`
- 📋 DALL-E generation: Copy prompts to ChatGPT Plus manually
- 📋 Image download: Save files with provided filenames
- 📋 CC download: Search Pexels/Wikimedia with provided terms
- 📋 File organization: Move to correct CategoryA/B/C folders

**Future Automation (Month 2-4):**
- 🔮 One-command generation: `generate-images CFF001`
- 🔮 Automatic folder creation
- 🔮 Batch DALL-E API calls
- 🔮 Auto-download and organize
- 🔮 Pexels/Wikimedia API integration

### API Library Structure

**Location:** `/mnt/project/M15_Image_Library_API.csv`

**Key Fields:**
- `Image_ID` - Unique identifier (IMG_FV_001, IMG_CFF_002, etc.)
- `Channel` - Which channel uses this image
- `Scene_Type` - Descriptive name (Office Ransacked, Money Trail, etc.)
- `Priority` - HIGH/MEDIUM/LOW (determines generation order)
- `Generation_Method` - DALLE/CC_ONLY/HYBRID
- `DALLE_Prompt` - Complete DALL-E 3 prompt
- `CC_Alternative_Source` - Pexels/Wikimedia Commons/N/A
- `CC_Search_Terms` - Terms for CC search
- `Quality_Score` - Expected quality 0-100

### Manual Workflow (Current Process)

**STEP 1: Generate Documents**
```
Command: "Generate CFF001"
Output: Voice Over Script + Image Gathering Guide + Production Script
```

**STEP 2: Create Folder Structure**
```bash
cd "/Volumes/JMC Ext Drive/Images"
mkdir -p CFF001/{CategoryA,CategoryB,CategoryC}
```

**STEP 3: Generate DALL-E Images (12 images, ~12 minutes)**
1. Open Image Gathering Guide (generated in Step 1)
2. Find "CATEGORY B: HIGH PRIORITY DALL-E" section
3. Copy first DALL-E prompt
4. Open ChatGPT Plus
5. Paste prompt, generate image (30 seconds)
6. Download image
7. Rename to filename from guide: `CFF001_B_001_abandoned_exchange.png`
8. Save to: `/Volumes/JMC Ext Drive/Images/CFF001/CategoryB/`
9. Repeat for all HIGH priority images

**STEP 4: Download CC Images (10 images, ~15 minutes)**
1. Find "CATEGORY C: LOW PRIORITY" section in guide
2. Open Pexels.com
3. Search using provided terms: "handcuffs metal chrome"
4. Download highest resolution
5. Rename to: `CFF001_C_001_handcuffs.jpg`
6. Save to: `/Volumes/JMC Ext Drive/Images/CFF001/CategoryC/`
7. Repeat for all CC images

**STEP 5: Research Category A Images (8 images, ~30 minutes)**
1. Find "CATEGORY A: SUBJECT-SPECIFIC" section
2. Follow research instructions for each image
3. Download real sources (court docs, photos, etc.)
4. Save to: `/Volumes/JMC Ext Drive/Images/CFF001/CategoryA/`

**TOTAL TIME: ~60 minutes per subject**

### File Organization Standard

**Required Structure:**
```
/Volumes/JMC Ext Drive/
├── Images/
│   ├── CFF001/
│   │   ├── CategoryA/          (Real evidence - research required)
│   │   │   ├── CFF001_A_001_cotten_photo.jpg
│   │   │   ├── CFF001_A_002_quadriga_logo.png
│   │   │   └── CFF001_A_003_court_filing.pdf
│   │   ├── CategoryB/          (DALL-E generated - from API prompts)
│   │   │   ├── CFF001_B_001_abandoned_exchange.png
│   │   │   ├── CFF001_B_002_server_room_dark.png
│   │   │   └── CFF001_B_003_tech_startup_dead.png
│   │   └── CategoryC/          (Creative Commons - from API search terms)
│   │       ├── CFF001_C_001_handcuffs.jpg
│   │       ├── CFF001_C_002_money_stack.jpg
│   │       └── CFF001_C_003_courtroom.jpg
│   ├── CFF002/
│   │   └── [same structure]
│   └── FV001/
│       └── [same structure]
```

**Naming Convention (Enforced by Image Gathering Guide):**
```
[SUBJECT_ID]_[CATEGORY]_[NUMBER]_[DESCRIPTOR].[ext]

Examples:
CFF001_A_001_cotten_photo.jpg      (Category A - Real)
CFF001_B_007_blockchain_viz.png    (Category B - DALL-E)
CFF001_C_012_generic_office.jpg    (Category C - Stock)
```

### Automatic Query Logic

When generating Image Gathering Guide for a subject:

```
STEP 1: Identify channel from Subject_ID
  CFF001 → Crypto_Forensic_Files
  FV009 → Financial_Vice
  USM015 → USA_Money_Flow

STEP 2: Query API library
  SELECT * FROM M15_Image_Library_API 
  WHERE Channel = [identified_channel]
  ORDER BY Priority DESC, Usage_Frequency DESC

STEP 3: Categorize results
  HIGH Priority + DALLE → Generate first (8-12 images)
  MEDIUM Priority → Evaluate per subject (5-8 images)
  LOW Priority + CC_ONLY → Download from CC (5-10 images)
  GENERIC images → Available for all channels

STEP 4: Populate Image Gathering Guide
  - Category B images: Include DALL-E prompts from library
  - Category C images: Include CC source + search terms
  - Category A images: Subject-specific (research required)
  - Category D images: Hybrid approach notes
```

### Integration Example

**User requests:** `Generate CFF001`

**System automatically:**
1. Identifies channel: `Crypto_Forensic_Files`
2. Queries library: Finds 7 HIGH priority images for CFF
3. Includes in Image Gathering Guide:
   - IMG_CFF_001: Abandoned Exchange (HIGH priority DALL-E)
   - IMG_CFF_002: Server Room Dark (HIGH priority DALL-E)
   - IMG_CFF_003: Tech Startup Dead (HIGH priority DALL-E)
   - IMG_CFF_004: Blockchain Collapse (HIGH priority DALL-E)
   - IMG_CFF_005: Crypto Flow (HIGH priority DALL-E)
   - IMG_CFF_006: Digital Heist (MEDIUM priority DALL-E)
   - IMG_CFF_007: Wallet Drain (MEDIUM priority DALL-E)
4. Plus GENERIC images available to all channels
5. Plus subject-specific Category A images (QuadrigaCX docs)

**Result:** Image Gathering Guide pre-populated with 12 HIGH/MEDIUM priority DALL-E prompts + 8 CC alternatives

---

## REFERENCE TRANSCRIPT INTEGRATION

### File Naming Convention
```
[SUBJECT_ID]_References.txt
```
Examples:
- `CFF001_QuadrigaCX_References.txt`
- `FV001_JimBakker_References.txt`

### Reference File Format
```
=== VIDEO: [Title] | [Creator] | [Year] ===
[Full transcript text]

=== VIDEO: [Title] | [Creator] | [Year] ===
[Full transcript text]
```

### Parsing Instructions

When a reference file exists in project files:

1. **Extract Verified Facts**
   - Names (correct spellings)
   - Dates (exact dates, not approximations)
   - Dollar amounts (precise figures)
   - Chronological sequences (what happened when)
   - Locations (specific addresses, cities, countries)

2. **Pull Direct Quotes**
   - Victim statements
   - Insider perspectives
   - Expert commentary
   - Court testimony excerpts
   - Format: "Quote text" — [Speaker Name/Role], [Source Video], [Year]

3. **Identify Differentiation Opportunities**
   - Angles already covered by other creators
   - Gaps in existing coverage (our unique angle)
   - Underexplored aspects of the story

4. **Flag Conflicts**
   - Note any conflicting facts across sources
   - Mark for manual verification: [VERIFY: conflicting info about X]

### Spotlight Quote Requirements

- Use ONLY quotes extracted from reference transcripts when available
- Minimum 2 distinct voices per series
- Format in script: *"Quote text"* — [Speaker], [Source], [Year]
- If insufficient quotes in references: [NEEDS ADDITIONAL RESEARCH: require victim/insider quotes]

---

## CHANNEL AUTO-DETECTION

Channel detected from keywords in request:

| Channel | Trigger Keywords |
|---------|-----------------|
| **Financial Vice** | fraud, scam, Ponzi, embezzlement, indictment, arrest, guilty, sentencing, prosecution, criminal |
| **Shadow Fortunes** | systemic, shadow banking, offshore, tax haven, Panama Papers, secrecy, black money |
| **Shadow Capitalism** | legal mechanism, wealth preservation, tax strategy, asset protection, trust, Delaware, loophole |
| **USA Money Flow** | federal spending, government contract, Medicare, defense spending, USASpending, taxpayer |
| **Crypto Forensic Files** | crypto, bitcoin, ethereum, exchange collapse, DeFi, blockchain fraud, rug pull |
| **Healthcare Heist** | Medicare fraud, pharma, hospital billing, insurance scam, medical device, opioid |
| **Real Estate Rackets** | mortgage fraud, foreclosure, property flip, REIT scam, housing bubble |
| **Political Money Flow** | lobbying, campaign finance, PAC, dark money, SuperPAC, Citizens United |
| **Tax Crimes** | tax evasion, IRS, offshore account, Swiss bank, tax shelter, unreported income |
| **Wall Street Predators** | hedge fund, short selling, market manipulation, insider trading, predatory lending |
| **Bankruptcy Billions** | bankruptcy, Chapter 11, creditors, liquidation, corporate collapse, restructuring |
| **Cartel Capital** | drug money, cartel, money laundering, narco, trafficking, organized crime |
| **Early Intel** | startup warning, red flags, due diligence, investor alert, pre-collapse |
| **Startup Graveyard** | failed startup, unicorn death, burn rate, pivot failure, shutdown |
| **Legal Billions** | class action, settlement, mass tort, verdict, lawsuit, plaintiffs |

If no keywords match → prompt user to specify channel.

---

## CHANNEL SPECIFICATIONS

[Rest of channel specs remain the same as v3...]

### 1. Financial Vice (FV)

```
Part 1: THE RISE (10-12 min) → Ends with Arrest/Collapse
Part 2: THE FALL (10-12 min) → Ends with Guilty Verdict
Part 3: THE RECKONING (10-12 min) → Ends with Sentencing/Justice
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 40-50%
- Tone: Prosecutorial, direct, judgmental
- Visual style: Noir documentary, dramatic shadows, desaturated with gold accents
- **API Library Images:** 8 templates (IMG_FV_001 through IMG_FV_008)

### 2. Shadow Fortunes (SF)

```
Part 1: THE SYSTEM (10-12 min) → Ends with Scale Revelation
Part 2: THE INVESTIGATION (10-12 min) → Ends with Exposure Event
Part 3: THE IMPLICATIONS (10-12 min) → Ends with Ongoing Impact
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 30-40%
- Tone: Analytical, systemic, investigative
- Visual style: Investigative documentary, surveillance aesthetic, muted earth tones
- **API Library Images:** 7 templates (IMG_SF_001 through IMG_SF_007)

### 3. Shadow Capitalism (SC)

```
Part 1: THE MECHANISM (10-12 min) → Ends with Mechanism Explained
Part 2: WHO USES IT (10-12 min) → Ends with Scale Revelation
Part 3: THE IMPLICATIONS (10-12 min) → Ends with Systemic Assessment
```

- Word count: 1,800-2,200 all parts
- Face time: 20-30% (LOWEST - most data visualization)
- Tone: Educational, neutral, mechanism-focused
- Visual style: Clean infographic, blues and grays, professional
- **API Library Images:** 6 templates (IMG_SC_001 through IMG_SC_006)

### 4. USA Money Flow (USM)

```
Part 1: THE SPENDING (10-12 min) → Ends with Dollar Amount Shock
Part 2: THE BENEFICIARIES (10-12 min) → Ends with Pattern Revelation
Part 3: THE ACCOUNTABILITY (10-12 min) → Ends with Systemic Questions
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 25-35%
- Tone: Data-driven, factual, accountability-focused
- Visual style: Government institutional, American palette, data journalism
- **API Library Images:** 6 templates (IMG_USM_001 through IMG_USM_006)

### 5. Crypto Forensic Files (CFF)

```
Part 1: THE PROMISE (10-12 min) → Ends with Red Flags Emerging
Part 2: THE FRAUD (10-12 min) → Ends with Collapse/Arrest
Part 3: THE COLLAPSE (10-12 min) → Ends with Victim Impact/Justice
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 35-45%
- Tone: Technical but accessible, exposé
- Visual style: Digital dystopia, glitch aesthetic, cyan/magenta on dark
- **API Library Images:** 7 templates (IMG_CFF_001 through IMG_CFF_007)

### 6. Healthcare Heist (HH)

```
Part 1: THE SCHEME (10-12 min) → Ends with Fraud Revealed
Part 2: THE VICTIMS (10-12 min) → Ends with Human Cost
Part 3: THE RECKONING (10-12 min) → Ends with Accountability/Reform
```

- Word count: 1,800-2,200 all parts
- Face time: 35-45%
- Tone: Empathetic to victims, harsh on perpetrators
- Visual style: Medical institutional, harsh fluorescent, clinical whites/greens
- **API Library Images:** 6 templates (IMG_HH_001 through IMG_HH_006)

### 7. Real Estate Rackets (RER)

```
Part 1: THE DEAL (10-12 min) → Ends with Warning Signs
Part 2: THE SCHEME (10-12 min) → Ends with Scheme Exposed
Part 3: THE FALLOUT (10-12 min) → Ends with Victim Stories/Justice
```

- Word count: 1,800-2,200 all parts
- Face time: 35-45%
- Tone: American Dream betrayed
- Visual style: Suburban documentary, warm fading to cold, property aesthetic
- **API Library Images:** 6 templates (IMG_RER_001 through IMG_RER_006)

### 8. Political Money Flow (PMF)

```
Part 1: THE POWER (10-12 min) → Ends with Money Source Revealed
Part 2: THE MONEY (10-12 min) → Ends with Influence Documented
Part 3: THE CONSEQUENCES (10-12 min) → Ends with Policy Impact
```

- Word count: 1,800-2,200 all parts
- Face time: 30-40%
- Tone: Non-partisan, accountability-focused
- Visual style: Political documentary, Capitol colors, formal institutional
- **API Library Images:** 6 templates (IMG_PMF_001 through IMG_PMF_006)

### 9. Tax Crimes (TC)

```
Part 1: THE EVASION (10-12 min) → Ends with Scale Revealed
Part 2: THE INVESTIGATION (10-12 min) → Ends with Caught
Part 3: THE PROSECUTION (10-12 min) → Ends with Sentencing/Recovery
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 35-45%
- Tone: Forensic, methodical, justice-oriented
- Visual style: IRS institutional, forensic accounting, money tones
- **API Library Images:** 6 templates (IMG_TC_001 through IMG_TC_006)

### 10. Wall Street Predators (WSP)

```
Part 1: THE SCHEME (10-12 min) → Ends with Mechanism Exposed
Part 2: THE VICTIMS (10-12 min) → Ends with Human Cost
Part 3: THE FALLOUT (10-12 min) → Ends with Accountability/Lack Thereof
```

- Word count: 1,800-2,200 all parts
- Face time: 35-45%
- Tone: Systemic critique, victim-centered
- Visual style: Financial thriller, trading floor aesthetic, Bloomberg greens
- **API Library Images:** 6 templates (IMG_WSP_001 through IMG_WSP_006)

### 11. Bankruptcy Billions (BB)

```
Part 1: THE EMPIRE (10-12 min) → Ends with Cracks Appearing
Part 2: THE COLLAPSE (10-12 min) → Ends with Filing/Shutdown
Part 3: THE AFTERMATH (10-12 min) → Ends with Creditor Fate/Lessons
```

- Word count: 1,800-2,200 all parts
- Face time: 30-40%
- Tone: Corporate autopsy
- Visual style: Collapse documentary, faded colors, corporate decay
- **API Library Images:** 6 templates (IMG_BB_001 through IMG_BB_006)

### 12. Cartel Capital (CC)

```
Part 1: THE OPERATION (10-12 min) → Ends with Scale Revealed
Part 2: THE MONEY (10-12 min) → Ends with Financial Networks Exposed
Part 3: THE TAKEDOWN (10-12 min) → Ends with Law Enforcement Action
```

- Word count: 1,900-2,300 (Part 1), 1,800-2,200 (Parts 2-3)
- Face time: 35-45%
- Tone: Crime documentary, serious, not glorifying
- Visual style: Surveillance aesthetic, desaturated with red accents
- **API Library Images:** 6 templates (IMG_CC_001 through IMG_CC_006)

### 13. Early Intel (EI)

```
Part 1: THE VISION (10-12 min) → Ends with Promise Established
Part 2: THE WARNING SIGNS (10-12 min) → Ends with Red Flags
Part 3: THE COLLAPSE (10-12 min) → Ends with Lessons/What to Watch
```

- Word count: 1,800-2,200 all parts
- Face time: 30-40%
- Tone: Cautionary, analytical
- Visual style: Tech journalism, startup aesthetic, promise betrayed
- **API Library Images:** 6 templates (IMG_EI_001 through IMG_EI_006)

### 14. Startup Graveyard (SG)

```
Part 1: THE HYPE (10-12 min) → Ends with Peak Valuation
Part 2: THE REALITY (10-12 min) → Ends with Problems Mounting
Part 3: THE DEATH (10-12 min) → Ends with Shutdown/Lessons
```

- Word count: 1,800-2,200 all parts
- Face time: 30-40%
- Tone: Post-mortem analysis, cautionary
- Visual style: Silicon Valley autopsy, fading tech colors
- **API Library Images:** 6 templates (IMG_SG_001 through IMG_SG_006)

### 15. Legal Billions (LB)

```
Part 1: THE HARM (10-12 min) → Ends with Victims United
Part 2: THE FIGHT (10-12 min) → Ends with Legal Battle Peak
Part 3: THE VERDICT (10-12 min) → Ends with Settlement/Verdict Impact
```

- Word count: 1,800-2,200 all parts
- Face time: 35-45%
- Tone: Justice-oriented, victim-focused
- Visual style: Courtroom documentary, legal browns, mass scale
- **API Library Images:** 6 templates (IMG_LB_001 through IMG_LB_006)

---

## AUTOMATIC DOCUMENT GENERATION

When user provides subject, automatically generate all 3 documents:

### 1. Voice Over Script (.docx)

- Professional formatting (Arial 12pt, 1.5 spacing)
- All face-to-camera segments
- All B-roll narration
- Italicized spotlight quotes
- Page breaks between parts
- No production notes (pure narration only)

### 2. Image Gathering Guide (.md)

**NOW AUTO-POPULATED FROM API LIBRARY**

- Query `M15_Image_Library_API.csv` for subject's channel
- Pull HIGH priority DALL-E prompts first
- Include MEDIUM priority images with evaluation notes
- List LOW priority CC alternatives
- Add subject-specific Category A images
- Estimated sourcing time: 45 minutes (reduced from 65 via automation)

### 3. Production Script (.md)

**This is the master editor document with full timing and specifications.**

---

## IMAGE GATHERING GUIDE FORMAT (API-INTEGRATED)

### New Format with API Integration

When generating Image Gathering Guide, system automatically queries API library and populates:

```markdown
## IMAGE GATHERING GUIDE - [SUBJECT_ID]

**AUTO-POPULATED FROM API LIBRARY**
Channel: [Channel Name]
Total Images Required: 25-30
- HIGH Priority DALL-E: 8-12 images
- MEDIUM Priority (Evaluate): 5-8 images
- LOW Priority CC: 5-10 images
- Subject-Specific Category A: 5-8 images

---

### CATEGORY B: HIGH PRIORITY DALL-E (Generate First)

**IMAGE 1: [Scene_Type from API]**
- CLASSIFICATION: B
- SOURCE: DALL-E 3 via ChatGPT Plus
- FILENAME: [SUBJECT_ID]_B_001_[scene_descriptor].png
- PRIORITY: HIGH (from API library IMG_[CHANNEL]_001)
- DALL-E PROMPT: [Complete prompt from API DALLE_Prompt field]
- QUALITY_SCORE: [Quality_Score from API]/100
- USAGE_FREQUENCY: [Usage_Frequency from API]
- GENERATION NOTE: [Notes from API + subject-specific adaptations]
- ATTRIBUTION: AI-Generated Illustration
- LEGAL: AI-Generated (Commercial Rights via ChatGPT Plus)

**IMAGE 2: [Scene_Type from API]**
[Same format, pulling from next HIGH priority API entry]

[Continue for all HIGH priority images from API library...]

---

### CATEGORY B: MEDIUM PRIORITY DALL-E (Evaluate Per Subject)

**IMAGE [X]: [Scene_Type from API]**
- CLASSIFICATION: B or C (evaluate)
- SOURCE: DALL-E 3 via ChatGPT Plus OR [CC_Alternative_Source from API]
- FILENAME: [SUBJECT_ID]_B_[NUMBER]_[descriptor].png
- PRIORITY: MEDIUM (from API library IMG_[CHANNEL]_[NUMBER])
- DALL-E PROMPT: [DALLE_Prompt from API]
- CC ALTERNATIVE: [CC_Alternative_Source from API]
- CC SEARCH TERMS: [CC_Search_Terms from API]
- QUALITY_SCORE: [Quality_Score]/100
- EVALUATION NOTE: CC available but DALL-E [Quality_Score difference] points better. Recommend [DALLE/CC based on subject importance]

[Continue for all MEDIUM priority images...]

---

### CATEGORY C: LOW PRIORITY (Use Creative Commons)

**IMAGE [Y]: [Scene_Type from API]**
- CLASSIFICATION: C
- SOURCE: [CC_Alternative_Source from API]
- SEARCH TERMS: [CC_Search_Terms from API]
- FILENAME: [SUBJECT_ID]_C_[NUMBER]_[descriptor].jpg
- PRIORITY: LOW (from API library)
- QUALITY_SCORE: [Quality_Score]/100
- DOWNLOAD INSTRUCTIONS: 
  1. Visit [CC_Alternative_Source]
  2. Search: "[CC_Search_Terms]"
  3. Download highest resolution
  4. Rename to filename above
- ATTRIBUTION: [Source-specific attribution from API]
- LEGAL: [License type from API]

[Continue for all LOW priority CC images...]

---

### CATEGORY A: SUBJECT-SPECIFIC (Real Sources Required)

**IMAGE [Z]: [Subject-specific description]**
- CLASSIFICATION: A
- SOURCE: [Specific source for this subject - NOT from generic API]
- FILENAME: [SUBJECT_ID]_A_[NUMBER]_[descriptor].pdf/jpg
- DESCRIPTION: [What this specific image shows]
- RESEARCH REQUIRED: Yes - subject-specific evidence
- WHERE TO FIND: [Specific instructions for this subject]
- ATTRIBUTION: [Source-specific]
- LEGAL: [Public Domain / Fair Use / etc.]

[Examples for CFF001 QuadrigaCX:]
**IMAGE A1: Gerald Cotten Mugshot/Photo**
- CLASSIFICATION: A
- SOURCE: News archives, court records
- WHERE TO FIND: Google News Archive search "Gerald Cotten photo"
- LEGAL: Fair Use (news reporting)

**IMAGE A2: QuadrigaCX Website Screenshot**
- CLASSIFICATION: A
- SOURCE: Archive.org Wayback Machine
- WHERE TO FIND: web.archive.org/web/*/quadrigacx.com
- LEGAL: Fair Use (historical documentation)

**IMAGE A3: Canadian Court Filing**
- CLASSIFICATION: A
- SOURCE: Canadian court records
- WHERE TO FIND: [Specific court case number + where to access]
- LEGAL: Public Domain (court records)

[Continue for all subject-specific Category A images...]

---

## IMAGE SOURCING SUMMARY

**Time Estimates:**
- Category B (HIGH): 12 images × 30 sec = 6 minutes generation + 6 min download = 12 min
- Category B (MEDIUM): Evaluation only (skip generation or 5 min)
- Category C (LOW): 10 images × 2 min each = 20 minutes batch download
- Category A (Subject-specific): 30 minutes research + download

**TOTAL TIME: 45-60 MINUTES** (reduced from 65 min via API automation)

**Cost Breakdown:**
- HIGH priority DALL-E: 12 images × $0 effective = $0 (within ChatGPT Plus)
- MEDIUM priority: Evaluate per subject ($0 if use CC)
- LOW priority CC: 10 images × $0 = $0
- Category A: $0 (public domain/fair use)

**TOTAL COST: $0 per subject**
```

---

## API LIBRARY QUERY EXAMPLES

### Example 1: Crypto Forensic Files Query

**User requests:** `Generate CFF001`

**System queries:**
```
SELECT * FROM M15_Image_Library_API
WHERE Channel = 'Crypto_Forensic_Files'
ORDER BY Priority DESC, Quality_Score DESC
```

**Results returned:**
- IMG_CFF_001: Abandoned Exchange (HIGH, 96 quality)
- IMG_CFF_002: Server Room Dark (HIGH, 90 quality)
- IMG_CFF_003: Tech Startup Dead (HIGH, 95 quality)
- IMG_CFF_004: Blockchain Collapse (HIGH, 97 quality)
- IMG_CFF_005: Crypto Flow (HIGH, 95 quality)
- IMG_CFF_006: Digital Heist (MEDIUM, 96 quality)
- IMG_CFF_007: Wallet Drain (MEDIUM, 94 quality)

**Plus GENERIC images:**
- IMG_GENERIC_001: Handcuffs (LOW, CC_ONLY)
- IMG_GENERIC_002: Money Stack (LOW, CC_ONLY)
- IMG_GENERIC_003: Courtroom (LOW, CC_ONLY)

**Auto-populated in Image Gathering Guide:**
- 7 CFF-specific images with complete DALL-E prompts
- 3 generic images with CC search terms
- 8-10 subject-specific Category A placeholders (research required)

**Total: 18-20 pre-populated images** ready for generation/download

### Example 2: Financial Vice Query

**User requests:** `Generate FV014` (Bernie Madoff)

**System queries:**
```
SELECT * FROM M15_Image_Library_API
WHERE Channel = 'Financial_Vice'
ORDER BY Priority DESC
```

**Results returned:**
- IMG_FV_001: Office Ransacked (HIGH)
- IMG_FV_002: Perp Walk (HIGH)
- IMG_FV_007: Money Trail (HIGH)
- IMG_FV_008: Golden Handcuffs (HIGH)
- IMG_FV_003: Luxury Jet Interior (MEDIUM)
- IMG_FV_005: Empty Boardroom (MEDIUM)
- IMG_FV_004: Prison Exterior (LOW, CC_ONLY)
- IMG_FV_006: Wealth Symbols (MEDIUM)

**Plus Bernie Madoff-specific Category A:**
- Madoff mugshot
- 715 Fifth Avenue offices
- Madoff Securities logo
- SEC complaint
- Victim impact statements
- Prison transfer photos

---

## SCRIPT STRUCTURE REQUIREMENTS

Every chapter MUST include 5 core elements:

1. **Spotlight** (≥2 voices per series, 30-60 words each) — Real quotes from reference transcripts
2. **Evergreen** (2-3 sentences, no temporal markers) — Content that won't date
3. **Audience Doubt** (pose + resolve) — Address skepticism directly
4. **Loop-Hook** (forward momentum) — Tease what's coming
5. **Emotional Question** (emotional weight) — Make viewer feel something

---

## FACE VS B-ROLL STRATEGY

**FACE segments (trust & authority):**
- Hook/intro (45-60 sec)
- Complex mechanism explanations
- Shocking revelations
- Chapter transitions (15-20 sec)
- Commentary/judgment
- Outro/CTA (30-45 sec)

**B-ROLL segments (pacing & information):**
- Dates, locations, dollar amounts
- Court documents, SEC filings
- Mugshots, arrest photos
- Company logos, building exteriors
- Charts, graphs, price crashes
- News headlines, screenshots

---

## IMAGE CLASSIFICATION SYSTEM

### Category A: REAL SOURCE REQUIRED

Images establishing factual credibility. AI generation prohibited.

**These are NOT in API library** - they're subject-specific.

| Image Type | Sources |
|------------|---------|
| Court documents | PACER, SEC.gov, DOJ.gov |
| Mugshots/arrest photos | FBI.gov, Sheriff offices, news archives |
| SEC filings/complaints | SEC.gov/litigation |
| Official company logos | Company websites, LinkedIn, Crunchbase |
| Government data/charts | FRED, BLS, USASpending.gov |
| Real news headlines | Archive.org, Google News |
| Blockchain explorer screenshots | Etherscan, Blockchain.com |
| Congressional testimony | C-SPAN, house.gov, senate.gov |
| Victim photos (if public) | News archives |
| Official government photos | .gov sites |

**Rule:** If it could be fact-checked or appears as evidence → MUST be real.

### Category B: AI-GENERATED (FROM API LIBRARY)

Conceptual, atmospheric, scene-setting images. **AUTO-POPULATED FROM API.**

**Query API library by:**
- Channel match
- Priority (HIGH/MEDIUM/LOW)
- Generation_Method = "DALLE"

| Image Type | API Template Available |
|------------|----------------------|
| Empty corporate offices | ✅ IMG_FV_001, IMG_BB_002 |
| Abstract money flows | ✅ IMG_FV_007, IMG_SF_006 |
| Shadowy boardrooms | ✅ IMG_FV_005 |
| Prison exteriors (generic) | ✅ IMG_FV_004 (but CC_ONLY) |
| Luxury items (generic) | ✅ IMG_FV_003, IMG_SF_004 |
| Digital fraud concepts | ✅ IMG_CFF_006, IMG_CFF_007 |
| Shell company webs | ✅ IMG_SF_003, IMG_SF_006 |
| Abandoned offices | ✅ IMG_CFF_001, IMG_SG_001 |

**Rule:** If it sets mood or illustrates concept → Query API library for prompt.

### Category C: STOCK/PUBLIC DOMAIN (FROM API LIBRARY)

Generic B-roll where quality free sources exist. **AUTO-POPULATED WITH CC SEARCH TERMS.**

**Query API library where:**
- CC_Alternative_Source != "N/A"
- Priority = "LOW"
- Generation_Method = "CC_ONLY"

| Image Type | API Search Terms Provided |
|------------|--------------------------|
| City skylines | ✅ "city skyline financial district" |
| Generic office workers | ✅ "office worker desk computer" |
| Courtroom interiors | ✅ "courtroom interior judge bench" |
| Capitol building | ✅ "Capitol building exterior" |
| Stock exchange floors | ✅ "trading floor empty screens" |
| Money/currency stacks | ✅ "stack cash hundred dollar bills" |
| Handcuffs | ✅ "handcuffs metal chrome" |

**Rule:** If high-quality free sources exist → API provides search terms.

### Category D: HYBRID

Real source foundation with AI-assisted visualization. **SUBJECT-SPECIFIC, NOT IN API.**

| Image Type | Approach |
|------------|----------|
| Timeline graphics | Real dates + DaVinci Fusion template |
| Money flow diagrams | Real amounts + AI visualization overlay |
| Data visualizations | Real data + stylized presentation |
| Organizational charts | Real names + visual hierarchy |
| Location maps | Real geography + stylized overlay |

**Rule:** Use real data as foundation, create in DaVinci Resolve or adapt API prompts.

---

## PRODUCTION SCRIPT SPECIFICATIONS

[Production script format remains the same as v3 - full timing, visual blocks, audio cues, etc.]

---

## REALISTIC TIME ESTIMATES (SOLO PRODUCTION)

### Per Subject (3-Part Series) - WITH API INTEGRATION

**Research & Category A gathering:** 30-60 minutes
- PACER/SEC/Archive.org searches
- Download court docs, screenshots
- Verify sources

**Script writing (all 3 parts):** 8-10 hours
- Part 1: 3.5-4 hours (2,300 words)
- Part 2: 2.5-3 hours (2,000 words)
- Part 3: 2.5-3 hours (2,000 words)

**Category B generation (DALL-E) - AUTOMATED PROMPTS:** 20-30 minutes ⚡
- Query API library: 0 minutes (automatic)
- 12 HIGH priority images × 30 sec = 6 min generation
- Download/organize: 8 min
- Quality check/refinement: 10 min
- **REDUCED FROM 45 MINUTES** via API automation

**Category C stock download - WITH API SEARCH TERMS:** 15-20 minutes
- API provides exact search terms
- Bulk download from Pexels/Wikimedia
- Systematic renaming

**Total per subject:** 9-11 hours (reduced from 10-12 via API)

### Weekly Production (2 Series/Week Solo) - API-ACCELERATED

**Monday:** Series 1 Parts 1-2 (8 hours)
- Morning: Category A + Part 1 script + **query API + generate images**
- Afternoon: Part 2 script + generate images

**Tuesday:** Series 1 Part 3 + Series 2 Part 1 (8 hours)
- Morning: Part 3 script + images + stock download
- Afternoon: Series 2 Category A + Part 1 script + **query API + generate**

**Wednesday:** Series 2 Parts 2-3 (8 hours)
- Morning: Part 2 script + generate images
- Afternoon: Part 3 script + images + stock download

**Thursday:** Voice recording both series (8 hours)
- Series 1: Parts 1-3 (4 hours)
- Series 2: Parts 1-3 (4 hours)

**Friday:** Basic editing 6 videos (8 hours)
- 6 videos × 80 min each = 8 hours
- Rough cuts complete

**Total:** 40 hours/week = 2 complete series (6 videos)
**Time saved via API:** 30-45 minutes per series = 1-1.5 hours/week

---

## API INTEGRATION BENEFITS

### Time Savings

**Before API (v3):**
- Image research: 30 min
- Prompt writing: 25 min
- Source evaluation: 10 min
- **Total: 65 minutes per subject**

**With API (v4):**
- API query: 0 min (automatic)
- Image generation: 6 min
- Download/organize: 8 min
- Quality check: 10 min
- **Total: 24 minutes for Category B**
- Category C with API search terms: 15 min
- **Total: 39 minutes per subject**

**Savings: 26 minutes per subject = 3.5 hours per month**

### Quality Improvements

✅ **Consistent channel aesthetics** - All prompts maintain visual identity
✅ **Pre-tested quality scores** - Know expected output before generating
✅ **Optimized cost decisions** - API Priority field guides DALL-E vs CC choice
✅ **Reusable templates** - HIGH usage_frequency images proven across subjects
✅ **No creative block** - Never stuck thinking "what image do I need?"

### Scalability

**Solo (Month 1-3):**
- API reduces cognitive load
- Focus on writing, not image sourcing
- 8 series/month sustainable

**Team (Month 4+):**
- Contractor can query API directly
- No creative decisions needed
- Clear instructions in API library
- 20+ series/month possible

---

## CRITICAL REMINDERS

- **One subject per run** — Reduces token usage, prevents interruptions
- **Check for reference file first** — `[SUBJECT_ID]_References.txt` in project files
- **Query API library automatically** — System pulls prompts for subject's channel
- **Use real quotes from transcripts** — No placeholder attributions when references exist
- **Generate ALL 3 documents** — Voice Over, Image Guide, Production Script
- **HIGH priority images first** — These are signature visuals, generate before CC alternatives
- **Classify EVERY image** — A/B/C/D with full specifications from API
- **Include timing for every segment** — Timestamps, durations, transitions
- **Never generate faces, logos, fake documents** — Hard rules apply
- **Word counts are runtime targets** — 150 words ≈ 1 minute
- **API library is master source** — Don't recreate prompts, query the library
- **Update API with learnings** — Track what works, refine prompts over time

---

## OUTPUT SPECIFICATIONS

### Voice Over Script (.docx)

- Format: Word document
- Font: Arial 12pt
- Line spacing: 1.5
- Headers: Hierarchical (Title → Part → Chapter)
- Italics: Spotlight quotes only
- Page breaks: Between parts
- No production notes: Pure narration only

### Image Gathering Guide (.md)

**NOW AUTO-POPULATED FROM API LIBRARY**

- Format: Markdown
- Sections: 
  1. API Library Summary (total images by category)
  2. Category B HIGH Priority (DALL-E prompts from API)
  3. Category B MEDIUM Priority (evaluation + CC alternatives from API)
  4. Category C LOW Priority (CC search terms from API)
  5. Category A Subject-Specific (research required, NOT from API)
- Each image: Complete specifications from API fields
- Estimated time: 45 minutes total per subject (reduced via API)

### Production Script (.md)

- Format: Markdown
- Full timestamp ranges for every segment
- [FACE] and [B-ROLL] tags
- Complete VISUAL blocks with duration, motion, transitions
- Complete AUDIO blocks with levels and cues
- TEXT OVERLAY specifications
- Teleprompter notes where relevant
- Timeline marker color codes

---

## FILE LOCATIONS

**API Library:** `/mnt/project/M15_Image_Library_API.csv`
**Subject References:** `/mnt/project/[SUBJECT_ID]_References.txt`
**Generated Outputs:** `/mnt/user-data/outputs/`

---

## VERSION HISTORY

**v4.0 (January 2026):**
- API Image Library integration
- Automatic prompt population from CSV
- Priority-based generation logic
- CC alternative search terms included
- Time estimates reduced via automation
- Cost optimization built into workflow

**v3.0 (January 2026):**
- DALL-E 3 integration
- Removed MLX Stable Diffusion
- Simplified prompts
- Realistic time estimates

**v2.0:**
- 15-channel expansion
- Reference transcript integration
- Production script specifications
