# TODO-1537: Refactor Heading Hierarchy for SEO

**Status:** 🟡 In Progress
**Priority:** High
**Created:** 2025-11-17
**Assignee:** Team
**Labels:** SEO, Content Structure, Accessibility

---

## 📋 Objective

Refactor all blog post content in `_post_with_city/` to implement proper heading hierarchy (H2 → H3 → H4) for better:
- **SEO optimization** - Google loves clear content structure
- **User experience** - Easy to scan and navigate
- **Accessibility** - Screen reader friendly
- **Table of Contents** - Auto-generate TOC from headings

---

## 🎯 Target Heading Structure

### Standard Template:
```markdown
## H2: Main Topic/Section (4-6 sections per article)
### H3: Sub-section
#### H4: Detailed point

Example hierarchy:
## H2: Mengapa Memilih Kami untuk Kayu Dolken [Location]
### H3: Keunggulan Layanan Kami
#### H4: Pengiriman Gratis
#### H4: Kualitas Premium
#### H4: Harga Terbaik
```

### Required H2 Sections (minimum):
1. **Mengapa Memilih Kami** - Value proposition
2. **Daftar Harga** - Product pricing (already exists)
3. **Jangkauan Area Pengiriman** - Coverage area
4. **Keunggulan Kayu Dolken Gelam** - Product benefits
5. **Aplikasi dan Kegunaan** - Use cases
6. **Cara Pemesanan** - How to order

---

## ✅ Refactoring Checklist

### 📄 Post Files (_post_with_city/)

- [ ] **2024-04-20-aplikasi-kayu-dolken-untuk-hotel-dan-cafe.md**
  - Current H2 count: ?
  - Target H2 count: 5-7
  - Status: Not started
  - Notes:

- [ ] **2025-11-15-jual-kayu-dolken-jakarta-utara.md**
  - Current H2 count: 1 (only "Daftar Harga")
  - Target H2 count: 6-8
  - Status: Not started
  - Notes: Identified as priority - has good content structure in HTML cards

- [ ] **2025-11-15-jual-kayu-dolken-semarang.md**
  - Current H2 count: ?
  - Target H2 count: 5-7
  - Status: Not started
  - Notes:

- [ ] **2025-11-15-jual-kayu-dolken-terdekat.md**
  - Current H2 count: ?
  - Target H2 count: 5-7
  - Status: Not started
  - Notes:

---

## 📝 Refactoring Process (Per File)

### Step 1: Analysis
```bash
# Check current heading structure
grep -n "^## \|^### \|^#### " filename.md
```

### Step 2: Identify Sections
- Read through content
- Identify logical sections from HTML cards
- Map HTML headings to semantic markdown headings

### Step 3: Convert HTML → Markdown Headings
```markdown
❌ Before (HTML in markdown):
<div class="card">
  <h3 class="h4">Mengapa Memilih Kami?</h3>
</div>

✅ After (Proper markdown):
## Mengapa Memilih Kami untuk Kayu Dolken [Location]

<div class="card">
  (visual styling remains)
</div>
```

### Step 4: Build Hierarchy
- H2: Main sections (5-7 per article)
- H3: Sub-sections under H2
- H4: Specific points under H3

### Step 5: Validate
- Check hierarchy flows logically
- No heading level skips (H2 → H4 ❌)
- Each H2 has meaningful sub-content
- Test TOC generation

---

## 🎨 Example Refactor

### Before (Jakarta Utara):
```markdown
## 💰 Daftar Harga Kayu Dolken Jakarta Utara

<div class="card">
  <h3 class="h4">Mengapa Memilih Kami?</h3>
  <h4 class="h6">Pengiriman Gratis</h4>
</div>
```

### After (Jakarta Utara):
```markdown
## Mengapa Memilih Kami untuk Kayu Dolken Jakarta Utara

### Keunggulan Layanan Kami

#### Pengiriman Gratis Jakarta Utara
(content...)

#### Kualitas Premium Grade A
(content...)

## Daftar Harga Kayu Dolken Jakarta Utara

(product list...)

## Jangkauan Area Pengiriman Gratis

### Wilayah Kelapa Gading
(coverage...)

### Wilayah Ancol
(coverage...)
```

---

## 🔍 Quality Criteria

Before marking a file as complete, ensure:
- [ ] At least 5 H2 headings
- [ ] Proper hierarchy (H2 → H3 → H4, no skips)
- [ ] Headings include target keywords naturally
- [ ] HTML visual cards preserved (don't remove styling)
- [ ] Semantic structure clear and logical
- [ ] No orphan headings (H3 without H2 parent)
- [ ] Content flows naturally under headings

---

## 📊 Progress Tracker

| File | H2 Count | Status | Completion |
|------|----------|--------|------------|
| aplikasi-kayu-dolken-untuk-hotel-dan-cafe.md | ? | 🔴 Not Started | 0% |
| jual-kayu-dolken-jakarta-utara.md | 1 → 6+ | 🔴 Not Started | 0% |
| jual-kayu-dolken-semarang.md | ? | 🔴 Not Started | 0% |
| jual-kayu-dolken-terdekat.md | ? | 🔴 Not Started | 0% |

**Overall Progress:** 0/4 files (0%)

---

## 🎯 SEO Benefits Expected

### Before Refactor:
- ❌ Poor heading structure (1-2 H2 only)
- ❌ Google can't understand content hierarchy
- ❌ No featured snippets eligibility
- ❌ Low content discoverability

### After Refactor:
- ✅ Rich heading hierarchy (6-8 H2 with H3, H4)
- ✅ Google understands content structure
- ✅ Eligible for featured snippets
- ✅ Better internal linking opportunities
- ✅ Higher content quality score
- ✅ Improved crawlability

---

## 📌 Related Tasks

- [ ] TODO-1538: Generate automatic Table of Contents
- [ ] TODO-1539: Add anchor links to headings
- [ ] TODO-1540: Schema markup for Article sections

---

## 🚀 Next Steps

1. Start with `jual-kayu-dolken-jakarta-utara.md` (highest priority)
2. Create template from Jakarta Utara refactor
3. Apply template to other 3 files
4. Validate SEO improvements in Search Console

---

## 📝 Notes

- Keep HTML cards for visual appeal (don't remove styling)
- Focus on semantic structure, not just aesthetics
- Use location-specific keywords in H2 headings
- Each article should be 5000+ words with proper structure
- Update this checklist as files are completed

---

**Last Updated:** 2025-11-17
**Next Review:** After first file completion
