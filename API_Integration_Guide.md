# M15 Image Library API Integration Guide

**Version:** 1.0  
**Purpose:** Automate image generation using ChatGPT API with intelligent DALL-E 3 / Creative Commons fallback logic

---

## OVERVIEW

The `M15_Image_Library_API.csv` serves as a master image library that can be:

1. **Queried programmatically** to find the right images for any subject
2. **Fed into ChatGPT API** to generate DALL-E 3 images automatically
3. **Fallback to Creative Commons** when CC images are adequate (cost savings)
4. **Track usage patterns** for optimization

---

## CSV FIELD DEFINITIONS

| Field | Type | Purpose | Values |
|-------|------|---------|--------|
| **Image_ID** | STRING | Unique identifier | `IMG_[CHANNEL]_[NUMBER]` |
| **Channel** | STRING | Which channel uses this | `Financial_Vice`, `Crypto_Forensic_Files`, etc. |
| **Category** | STRING | Type of image | `Atmospheric`, `Location`, `Conceptual`, `Documents`, `Evidence`, `Lifestyle`, `Institutional`, `Generic` |
| **Scene_Type** | STRING | Descriptive name | `Office Ransacked`, `Money Trail`, etc. |
| **Priority** | STRING | Generation priority | `HIGH`, `MEDIUM`, `LOW` |
| **Generation_Method** | STRING | How to obtain | `DALLE`, `CC_ONLY`, `HYBRID` |
| **DALLE_Prompt** | TEXT | Complete DALL-E 3 prompt | Full prompt text or `N/A` |
| **CC_Alternative_Source** | STRING | Where to find CC version | `Pexels`, `Wikimedia Commons`, `N/A` |
| **CC_Search_Terms** | STRING | Search terms for CC source | Terms to search or `N/A` |
| **API_Cost_Score** | INTEGER | Relative cost (0-100) | `0` = free CC, higher = more DALL-E calls |
| **Quality_Score** | INTEGER | Expected quality (0-100) | `95+` = premium, `80-94` = good, `<80` = adequate |
| **Usage_Frequency** | STRING | How often needed | `HIGH`, `MEDIUM`, `LOW` |
| **Notes** | TEXT | Additional context | Usage notes, warnings, alternatives |

---

## DECISION LOGIC FLOWCHART

```
START: Need image for scene
    ↓
QUERY CSV for Scene_Type + Channel
    ↓
Found match?
    ├─ YES → Check Generation_Method
    │         ├─ DALLE → Generate with DALL-E 3 via API
    │         ├─ CC_ONLY → Download from CC_Alternative_Source
    │         └─ HYBRID → Generate DALL-E + overlay real data
    │
    └─ NO → Check if generic equivalent exists
              ├─ YES → Use generic (IMG_GENERIC_XXX)
              └─ NO → Create custom DALL-E prompt
```

---

## PRIORITY SCORING SYSTEM

### HIGH Priority (Generate First)

**Criteria:**
- No Creative Commons equivalent exists
- Unique channel aesthetic (e.g., CFF cyan glow)
- Complex visualizations (money flows, networks)
- Conceptual metaphors (icebergs, drowning houses)
- High usage frequency across multiple subjects

**Cost Justification:** These are signature visuals that differentiate your channels. No CC alternative achieves the same quality/mood.

**Examples:**
- `IMG_CFF_001` - Abandoned crypto exchange (signature CFF aesthetic)
- `IMG_FV_007` - Money trail visualization (complex concept)
- `IMG_SF_006` - Global money web (network visualization)

### MEDIUM Priority (Generate Selectively)

**Criteria:**
- Creative Commons alternatives exist BUT DALL-E is notably better
- Atmospheric scenes where mood/lighting critical
- Moderate usage frequency
- Quality difference is 10+ points

**Cost Justification:** Worth generating for premium subjects or when CC options are generic/low quality.

**Examples:**
- `IMG_FV_005` - Empty boardroom (CC exists but DALL-E better mood)
- `IMG_HH_003` - Pharma warehouse (CC adequate but angle better)
- `IMG_RER_002` - Empty development (CC exists but DALL-E captures decay better)

### LOW Priority (Use CC)

**Criteria:**
- High-quality CC alternatives readily available
- Generic B-roll scenes
- Government buildings (real photos preferred)
- Simple objects (handcuffs, gavels, money stacks)

**Cost Justification:** DALL-E provides minimal quality improvement over free CC options.

**Examples:**
- `IMG_USM_001` - Pentagon (use real government photos)
- `IMG_GENERIC_001` - Handcuffs (abundant CC options)
- `IMG_PMF_003` - Hearing room (real Capitol photos available)

---

## API USAGE PATTERNS

### Pattern 1: Batch Generation for New Subject

**Scenario:** Starting CFF001 QuadrigaCX production

**Process:**
1. Query CSV for `Channel = "Crypto_Forensic_Files"` AND `Priority = "HIGH"`
2. Extract all `DALLE_Prompt` values
3. Send to ChatGPT API in batch (up to 50/day limit)
4. Download and organize with systematic naming
5. Fall back to CC for `Priority = "LOW"` items

**Expected Output:**
- 8-12 HIGH priority DALL-E images generated
- 5-8 MEDIUM priority evaluated (generate if budget allows)
- 10-15 LOW priority sourced from CC (zero cost)

**API Call Example:**

```javascript
// Get HIGH priority images for CFF channel
const highPriorityImages = csvData.filter(row => 
  row.Channel === "Crypto_Forensic_Files" && 
  row.Priority === "HIGH" &&
  row.Generation_Method === "DALLE"
);

// Generate each in sequence
for (const image of highPriorityImages) {
  const response = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "claude-sonnet-4-20250514",
      max_tokens: 1000,
      messages: [
        {
          role: "user",
          content: `Generate a DALL-E 3 image with this prompt: ${image.DALLE_Prompt}`
        }
      ]
    })
  });
  
  // Save with systematic naming: CFF001_B_001_scene.png
  const filename = `CFF001_B_${String(index + 1).padStart(3, '0')}_${image.Scene_Type.toLowerCase().replace(/\s+/g, '_')}.png`;
}
```

### Pattern 2: On-Demand Generation During Writing

**Scenario:** Writing script, need specific image

**Process:**
1. Writer identifies need: "Need abandoned exchange office shot"
2. Search CSV: `Scene_Type CONTAINS "Abandoned Exchange"`
3. If match found with `Generation_Method = "DALLE"`:
   - Use existing prompt from CSV
4. If no match:
   - Check for similar `Scene_Type` in same `Channel`
   - Adapt existing prompt OR
   - Create custom prompt following channel style guidelines

**API Call Example:**

```javascript
// Search for specific scene
const searchTerm = "abandoned exchange";
const matchingImage = csvData.find(row => 
  row.Scene_Type.toLowerCase().includes(searchTerm.toLowerCase())
);

if (matchingImage && matchingImage.Generation_Method === "DALLE") {
  // Use existing prompt
  generateImage(matchingImage.DALLE_Prompt);
} else {
  // Create custom following channel aesthetic
  const channelStyle = getChannelStyle("Crypto_Forensic_Files");
  const customPrompt = `${searchTerm}, ${channelStyle}`;
  generateImage(customPrompt);
}
```

### Pattern 3: Cost-Optimized Hybrid Approach

**Scenario:** Producing 2 series/week on solo budget

**Process:**
1. Filter CSV for current subject's channel
2. Generate HIGH priority images only (8-12 images)
3. Download MEDIUM priority from CC sources (10-15 images)
4. Use generic library for LOW priority (5-8 images)
5. Total: 25 images, ~10-12 DALL-E calls per series

**Budget Impact:**
- HIGH priority: 12 DALL-E calls × $0 effective = $0
- MEDIUM priority: 0 DALL-E calls (use CC) = $0
- LOW priority: 0 DALL-E calls (use CC/generic) = $0
- **Total cost per series: $0** (within ChatGPT Plus subscription)

**API Call Example:**

```javascript
// Cost-optimized approach
const images = {
  dalle: csvData.filter(row => 
    row.Channel === currentChannel && 
    row.Priority === "HIGH" && 
    row.Generation_Method === "DALLE"
  ),
  creative_commons: csvData.filter(row => 
    row.Channel === currentChannel && 
    (row.Priority === "MEDIUM" || row.Priority === "LOW") &&
    row.CC_Alternative_Source !== "N/A"
  )
};

// Generate DALL-E batch
await generateBatch(images.dalle.map(img => img.DALLE_Prompt));

// Download CC images
await downloadCC(images.creative_commons);
```

---

## CREATIVE COMMONS INTEGRATION

### Pexels API Integration

**Setup:**
1. Get free API key: https://www.pexels.com/api/
2. 200 requests/hour, unlimited images/month
3. No attribution required for downloaded images

**Example Implementation:**

```javascript
async function downloadFromPexels(searchTerms, filename) {
  const response = await fetch(
    `https://api.pexels.com/v1/search?query=${encodeURIComponent(searchTerms)}&per_page=5`,
    {
      headers: {
        Authorization: 'YOUR_PEXELS_API_KEY'
      }
    }
  );
  
  const data = await response.json();
  
  // Download highest resolution
  const imageUrl = data.photos[0].src.original;
  await downloadImage(imageUrl, filename);
}
```

**When to Use:**
- `CC_Alternative_Source = "Pexels"`
- `Priority = "LOW"` or `Priority = "MEDIUM"`
- Generic B-roll needs

### Wikimedia Commons API

**Setup:**
1. No API key required
2. Unlimited requests (reasonable rate)
3. Attribution required (stored in CSV)

**Example Implementation:**

```javascript
async function downloadFromWikimedia(searchTerms, filename) {
  const response = await fetch(
    `https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch=${encodeURIComponent(searchTerms)}&srnamespace=6&format=json`
  );
  
  const data = await response.json();
  const topResult = data.query.search[0];
  
  // Get image URL and attribution
  const imageUrl = await getWikimediaImageUrl(topResult.title);
  const attribution = await getWikimediaAttribution(topResult.title);
  
  await downloadImage(imageUrl, filename, { attribution });
}
```

**When to Use:**
- `CC_Alternative_Source = "Wikimedia Commons"`
- Government buildings, historical locations
- Any image where real photos preferred

---

## USAGE FREQUENCY TRACKING

### Purpose

Track which images are used most frequently to:
1. Prioritize future DALL-E generation
2. Identify reusable assets across subjects
3. Optimize library over time

### Implementation

Add usage tracking to CSV:

```javascript
// After using an image
function recordImageUsage(imageId, subjectId) {
  // Update usage counter
  const image = csvData.find(row => row.Image_ID === imageId);
  image.usage_count = (image.usage_count || 0) + 1;
  image.last_used = new Date().toISOString();
  image.used_in_subjects = image.used_in_subjects 
    ? `${image.used_in_subjects},${subjectId}` 
    : subjectId;
  
  // Save updated CSV
  saveCSV(csvData);
}
```

### Analytics Queries

**Most reused images:**
```javascript
const topImages = csvData
  .filter(row => row.usage_count > 5)
  .sort((a, b) => b.usage_count - a.usage_count)
  .slice(0, 20);
```

**ROI calculation:**
```javascript
const highValueImages = csvData
  .filter(row => 
    row.Generation_Method === "DALLE" && 
    row.usage_count > 3
  )
  .map(row => ({
    id: row.Image_ID,
    uses: row.usage_count,
    effective_cost: 0.10 / row.usage_count // $0.10 amortized
  }));
```

---

## AUTOMATION WORKFLOW

### Full Automation (Future State)

**Trigger:** User command `Generate CFF001`

**Automated Process:**

```javascript
async function generateSubjectImages(subjectId) {
  // 1. Determine channel from subject ID
  const channel = subjectId.substring(0, 3); // "CFF"
  const channelName = getChannelName(channel);
  
  // 2. Query image library
  const images = {
    dalle_high: csvData.filter(row => 
      row.Channel === channelName && 
      row.Priority === "HIGH" &&
      row.Generation_Method === "DALLE"
    ),
    dalle_medium: csvData.filter(row => 
      row.Channel === channelName && 
      row.Priority === "MEDIUM" &&
      row.Generation_Method === "DALLE"
    ),
    cc_sources: csvData.filter(row => 
      row.Channel === channelName &&
      row.CC_Alternative_Source !== "N/A"
    )
  };
  
  // 3. Generate HIGH priority DALL-E images
  console.log(`Generating ${images.dalle_high.length} HIGH priority images...`);
  for (const [index, image] of images.dalle_high.entries()) {
    const filename = `${subjectId}_B_${String(index + 1).padStart(3, '0')}_${image.Scene_Type.toLowerCase().replace(/\s+/g, '_')}.png`;
    await generateDALLE3Image(image.DALLE_Prompt, filename);
    await recordImageUsage(image.Image_ID, subjectId);
  }
  
  // 4. Download CC alternatives for MEDIUM/LOW
  console.log(`Downloading ${images.cc_sources.length} Creative Commons images...`);
  for (const [index, image] of images.cc_sources.entries()) {
    const filename = `${subjectId}_C_${String(index + 1).padStart(3, '0')}_${image.Scene_Type.toLowerCase().replace(/\s+/g, '_')}.jpg`;
    
    if (image.CC_Alternative_Source === "Pexels") {
      await downloadFromPexels(image.CC_Search_Terms, filename);
    } else if (image.CC_Alternative_Source === "Wikimedia Commons") {
      await downloadFromWikimedia(image.CC_Search_Terms, filename);
    }
    
    await recordImageUsage(image.Image_ID, subjectId);
  }
  
  // 5. Generate usage report
  console.log(`\nImage Generation Complete for ${subjectId}:`);
  console.log(`- DALL-E 3 images: ${images.dalle_high.length}`);
  console.log(`- Creative Commons: ${images.cc_sources.length}`);
  console.log(`- Total cost: $0 (within ChatGPT Plus subscription)`);
  console.log(`- Total time: ~${images.dalle_high.length * 0.5} minutes`);
}
```

### Semi-Automated (Current State)

**Process:**
1. **Manual:** User identifies needed scenes while writing script
2. **Automated:** Script queries CSV for matching prompts
3. **Manual:** User reviews and selects from options
4. **Automated:** Batch generation via ChatGPT API
5. **Automated:** Download and organize with systematic naming

---

## QUALITY ASSURANCE

### Pre-Generation Checklist

Before generating images from CSV:

□ **Verify channel match:** Scene_Type appropriate for current channel?
□ **Check priority:** Is this HIGH priority or can CC substitute?
□ **Review prompt:** Does DALL-E prompt match channel aesthetic?
□ **Confirm naming:** Filename follows convention?
□ **Track usage:** Will this be reused across subjects?

### Post-Generation Review

After generating DALL-E images:

□ **Visual quality:** Meets Quality_Score target?
□ **No text artifacts:** DALL-E didn't add gibberish text?
□ **No unwanted faces:** If faces present, were they intended?
□ **Channel consistency:** Matches channel visual style?
□ **Update CSV:** Record usage, update quality scores

### Continuous Improvement

**Monthly review:**
1. Identify low-performing prompts (Quality_Score < target)
2. Update prompts based on successful generations
3. Add new Scene_Types discovered during production
4. Archive unused images (Usage_Frequency = 0 after 3 months)

---

## COST TRACKING

### Current Model (ChatGPT Plus)

**Fixed cost:** $20/month
**DALL-E limit:** ~50 images/day
**Effective cost per image:** $0.10 if generating 200/month

### Monthly Budget Scenarios

**Scenario 1: Solo Production (2 series/week)**
- Series per month: 8
- HIGH priority images per series: 12
- Total DALL-E calls: 96/month
- Total cost: $0 (within subscription)
- CC alternatives: 120 images (zero cost)

**Scenario 2: Team Production (5 series/week)**
- Series per month: 20
- HIGH priority images per series: 12
- Total DALL-E calls: 240/month
- Total cost: $0 base + possible overage
- Need to monitor daily limits

**Scenario 3: Full Scale (12 series/week)**
- Series per month: 48
- HIGH priority images per series: 12
- Total DALL-E calls: 576/month
- Exceeds free limit - need additional solution:
  - Option A: Multiple ChatGPT Plus accounts ($40-60/month)
  - Option B: Direct OpenAI API (~$200/month at scale)
  - Option C: Hybrid (DALL-E for premium + more CC)

### ROI Calculation

**Cost per video (current):**
- DALL-E images: 12 × $0.10 = $1.20/video
- Alternative (stock photos): 25 × $15 = $375/video
- **Savings: $373.80 per video**

**Annual projection:**
- Videos per year: 288 (24/month × 12)
- Stock photo cost: $108,000
- DALL-E cost: $345.60
- **Annual savings: $107,654.40**

---

## INTEGRATION WITH SKILL FILE

### Automatic Prompt Injection

When generating Voice Over Script, automatically inject relevant prompts:

```javascript
// During Image Gathering Guide generation
function generateImageGatheringGuide(subjectId, channel) {
  const relevantImages = csvData.filter(row => 
    row.Channel === channel
  );
  
  let guide = "## IMAGE GATHERING GUIDE\n\n";
  
  for (const image of relevantImages) {
    guide += `**IMAGE: ${image.Scene_Type}**\n`;
    guide += `- CLASSIFICATION: ${image.Generation_Method === "DALLE" ? "B" : "C"}\n`;
    guide += `- PRIORITY: ${image.Priority}\n`;
    
    if (image.Generation_Method === "DALLE") {
      guide += `- DALL-E PROMPT: ${image.DALLE_Prompt}\n`;
    } else {
      guide += `- SOURCE: ${image.CC_Alternative_Source}\n`;
      guide += `- SEARCH: ${image.CC_Search_Terms}\n`;
    }
    
    guide += `- QUALITY SCORE: ${image.Quality_Score}/100\n\n`;
  }
  
  return guide;
}
```

### Dynamic Scene Type Matching

Match script scenes to library:

```javascript
// Parse script for B-roll segments
function matchScriptToLibrary(scriptText, channel) {
  const scenes = extractBrollScenes(scriptText);
  const matches = [];
  
  for (const scene of scenes) {
    // Try exact match
    let match = csvData.find(row => 
      row.Channel === channel &&
      row.Scene_Type.toLowerCase() === scene.description.toLowerCase()
    );
    
    // Try fuzzy match
    if (!match) {
      match = fuzzyMatch(scene.description, csvData, channel);
    }
    
    matches.push({
      scene: scene,
      libraryImage: match,
      confidence: calculateConfidence(scene, match)
    });
  }
  
  return matches;
}
```

---

## FUTURE ENHANCEMENTS

### Phase 1: Basic Automation (Month 2)
- CSV query functions
- Manual ChatGPT API calls
- Systematic file organization

### Phase 2: Semi-Automation (Month 4)
- Batch generation scripts
- CC source integration
- Usage tracking

### Phase 3: Full Automation (Month 9)
- One-command subject generation
- Intelligent CC fallback
- Quality scoring feedback loop
- Cost optimization algorithms

### Phase 4: AI-Assisted Library Growth (Month 12)
- Automatic new Scene_Type discovery
- Prompt optimization based on results
- Cross-channel pattern recognition
- Predictive image needs based on subject

---

## QUICK REFERENCE

### Common Queries

**Get all HIGH priority DALL-E prompts for a channel:**
```javascript
csvData.filter(row => 
  row.Channel === "Crypto_Forensic_Files" && 
  row.Priority === "HIGH" &&
  row.Generation_Method === "DALLE"
)
```

**Find CC alternatives for a scene:**
```javascript
csvData.find(row => 
  row.Scene_Type.includes("Empty Boardroom") &&
  row.CC_Alternative_Source !== "N/A"
)
```

**Calculate cost for a subject:**
```javascript
const dalleCount = csvData.filter(row => 
  row.Channel === currentChannel && 
  row.Generation_Method === "DALLE"
).length;

const cost = dalleCount * 0.10; // Effective cost per image
```

**Find reusable images:**
```javascript
csvData.filter(row => 
  row.Usage_Frequency === "HIGH" &&
  row.Quality_Score > 90
)
```

---

## SUPPORT & DOCUMENTATION

**CSV Location:** `/Volumes/JMC Ext Drive/M15_Image_Library_API.csv`
**Backup:** Git repository + monthly exports
**Updates:** Add new Scene_Types as discovered during production
**Issues:** Track in separate `Image_Library_Issues.csv`

**Contact for library updates:** Update CSV directly, commit to repo
