# TODO-1538: Modular Post Template System for Regular Posts

**Status:** 🔵 Planned
**Priority:** High
**Created:** 2025-11-20
**Assignee:** Team
**Labels:** Templates, Architecture, DX, Scalability

---

## 📋 Objective

Create a modular template system for regular blog posts (`_posts/`) following the successful pattern from `_post_with_city/`. This will enable:
- **Consistency** - All posts use standardized reusable blocks
- **Maintainability** - Update one block = update all posts
- **Scalability** - Easy to add new content types and templates
- **Developer Experience** - Clear structure, minimal code duplication
- **Content Reusability** - Mix and match blocks based on content needs

> **📚 Documentation Structure:**
> This is the **master plan** document. Detailed specifications are documented in:
> - **TODO-1538-yaml-schema-and-block-pattern.md** - YAML Schema & Block Pattern (H2→3×H3→3×H4 strict hierarchy, HTML blocks, Bootstrap components)

---

## 🏗️ Architecture Overview

### Three-Layer Architecture:
```
┌─────────────────────────────────────────┐
│  LAYER 1: FRONTMATTER (Data)            │
│  - Structured YAML data                 │
│  - No hardcoded content in HTML         │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  LAYER 2: CONTENT (Structure)           │
│  - {% include %} blocks only            │
│  - Separation of concerns               │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│  LAYER 3: BLOCKS (Presentation)         │
│  - Reusable HTML components             │
│  - _includes/{template-name}/           │
└─────────────────────────────────────────┘
```

---

## 📂 Folder Structure

### New Folders in `_includes/`:
```
_includes/
├── posts/                       # Post template blocks (organized by type)
│   ├── tutorial/                # 🆕 Tutorial template blocks (standalone/complete)
│   │   ├── block--intro-section.html
│   │   ├── block--tutorial-meta.html
│   │   ├── block--content-section.html
│   │   ├── block--tips-list.html
│   │   ├── block--common-mistakes.html
│   │   ├── block--calculator-tool.html
│   │   ├── block--kesimpulan.html
│   │   ├── block--faq.html
│   │   └── block--cta-box.html
│   │
│   ├── comparison/              # 🆕 Comparison template blocks (standalone/complete)
│   │   ├── block--intro-section.html
│   │   ├── block--comparison-table.html
│   │   ├── block--pros-cons.html
│   │   ├── block--feature-matrix.html
│   │   ├── block--recommendation.html
│   │   ├── block--kesimpulan.html
│   │   └── block--faq.html
│   │
│   ├── guide/                   # 🆕 Guide template blocks (standalone/complete)
│   │   ├── block--intro-section.html
│   │   ├── block--guide-sections.html
│   │   ├── block--best-practices.html
│   │   ├── block--quick-reference.html
│   │   ├── block--do-dont-list.html
│   │   ├── block--kesimpulan.html
│   │   └── block--faq.html
│   │
│   ├── shared-block/            # ⚠️ OLD pattern (will be deprecated)
│   └── [custom per-post]/       # ✅ Existing (custom blocks per specific post)
│       ├── hitung-kebutuhan-kayu-dolken-untuk-proyek/
│       └── perawatan-kayu-dolken-gelam-agar-awet/
│
└── products/                    # ✅ Existing (product-specific blocks)
    ├── block--product-rekomendasi.html
    └── block--product-keunggulan.html
```

**Note:** Each template type (tutorial, comparison, guide) has its own **complete set of blocks**. No inheritance or shared blocks between templates - each is standalone.

---

## 📝 Template Files to Create

### Phase 1: Core Templates (Priority: High)
```
TEMPLATES/
├── TEMPLATE--post-tutorial.md      # ✅ CREATED - How-to / Step-by-step guides
├── TEMPLATE--post-comparison.md    # 🔜 TODO - Versus / Comparison articles
└── TEMPLATE--post-guide.md         # 🔜 TODO - Comprehensive guides
```

### Phase 2: Additional Templates (Priority: Medium)
```
TEMPLATES/
├── TEMPLATE--post-listicle.md      # Top 10, Tips, Lists
├── TEMPLATE--post-case-study.md    # Project case studies
└── TEMPLATE--post-review.md        # Product reviews
```

### Phase 3: Documentation (Priority: Medium)
```
TEMPLATES/
├── DOCS--post-template-guide.md    # Documentation for using templates
├── README--post-templates.md       # Quick reference guide
└── checklist-post-creation.md      # Content creation workflow
```

**Note:** Each template is **standalone and complete**. No base template or inheritance pattern.

---

## 🎯 Template Specifications

### TEMPLATE--post-tutorial.md ✅ CREATED
**Purpose:** Step-by-step how-to guides
**Status:** Complete
**Location:** `TEMPLATES/TEMPLATE--post-tutorial.md`

**Blocks Required (all in `_includes/posts/tutorial/`):**
- ✅ `block--intro-section.html`
- ✅ `block--tutorial-meta.html` (difficulty, time, tools)
- ✅ `block--content-section.html` (H2→3×H3→3×H4 structure)
- ✅ `block--tips-list.html`
- ✅ `block--common-mistakes.html`
- ✅ `block--calculator-tool.html` (optional)
- ✅ `block--kesimpulan.html`
- ✅ `block--faq.html`
- ✅ `block--cta-box.html`

**Additional Frontmatter:**
```yaml
template_type: step-by-step

# Step-by-step guide
steps:
  - nomor: 1
    judul: "Step 1 Title"
    deskripsi: "..."
    substeps: [...]
    image: "step-1.webp"
    formula: "..." (optional)

# Tips section (optional)
tips:
  - judul: "Tip Title"
    deskripsi: "..."
    icon: "bi-lightbulb"

# Common mistakes (optional)
common_mistakes:
  - mistake: "Kesalahan"
    solution: "Solusi"
    icon: "bi-x-circle"
```

**Example Use Case:**
- Cara Menghitung Kebutuhan Kayu Dolken
- Cara Memasang Pagar Dolken
- Tutorial Perawatan Kayu Gelam

---

### TEMPLATE--post-comparison.md
**Purpose:** A vs B comparison articles
**Extends:** TEMPLATE--post-base.md
**Blocks Required:**
- ✅ All base blocks
- ✅ `post-comparison/block--comparison-table.html`
- ✅ `post-comparison/block--pros-cons.html`
- ✅ `post-comparison/block--recommendation.html`

**Additional Frontmatter:**
```yaml
template_type: versus

# Comparison subjects
comparison:
  subject_a:
    nama: "Kayu Gelam"
    icon: "bi-tree"
    warna: "success"

  subject_b:
    nama: "Kayu Ulin"
    icon: "bi-tree-fill"
    warna: "secondary"

  kriteria:
    - nama: "Ketahanan"
      subject_a: "20-30 tahun"
      subject_b: "30-50 tahun"
      winner: "b"
      keterangan: "..."

# Pros & cons
pros_cons:
  subject_a:
    pros: [...]
    cons: [...]
  subject_b:
    pros: [...]
    cons: [...]

# Final recommendation
recommendation:
  winner: "a" | "b" | "depends"
  reason: "..."
  use_case_a: "..."
  use_case_b: "..."
```

**Example Use Case:**
- Kayu Gelam vs Kayu Ulin
- Dolken vs Beton untuk Pagar
- Kayu Natural vs Kayu Treated

---

### TEMPLATE--post-guide.md
**Purpose:** Comprehensive guides
**Extends:** TEMPLATE--post-base.md
**Blocks Required:**
- ✅ All base blocks
- ✅ `post-guide/block--guide-sections.html`
- ✅ `post-guide/block--best-practices.html`
- ✅ `post-guide/block--quick-reference.html`

**Additional Frontmatter:**
```yaml
template_type: comprehensive

# Guide sections
sections:
  - id: "overview"
    judul: "Overview"
    deskripsi: "..."
    subsections:
      - subjudul: "Point 1"
        konten: "..."
      - subjudul: "Point 2"
        konten: "..."

# Best practices
best_practices:
  do:
    - "Best practice 1"
    - "Best practice 2"
  dont:
    - "Avoid this 1"
    - "Avoid this 2"

# Quick reference table
quick_reference:
  - label: "Quick info 1"
    value: "Value 1"
  - label: "Quick info 2"
    value: "Value 2"
```

**Example Use Case:**
- Panduan Lengkap Kayu Dolken Gelam
- Perawatan Kayu Dolken Agar Awet
- Memilih Ukuran Kayu Dolken yang Tepat

---

## ✅ Implementation Checklist

### Phase 1: Foundation Setup
- [ ] Create folder structure in `_includes/`
  - [ ] `_includes/post-base/`
  - [ ] `_includes/post-tutorial/`
  - [ ] `_includes/post-comparison/`
  - [ ] `_includes/post-guide/`

- [ ] Create base template files
  - [ ] `TEMPLATE--post-base.md`
  - [ ] `DOCS--post-template-guide.md`
  - [ ] `README--post-templates.md`
  - [ ] `checklist-post-creation.md`

- [ ] Create base blocks
  - [ ] `post-base/block--intro-section.html`
  - [ ] `post-base/block--kesimpulan.html`
  - [ ] `post-base/block--image-carousel.html`
  - [ ] `post-base/block--social-metrics.html`

### Phase 2: Tutorial Template (Priority)
- [ ] Create `TEMPLATE--post-tutorial.md`
- [ ] Create tutorial blocks:
  - [ ] `post-tutorial/block--step-by-step-guide.html`
  - [ ] `post-tutorial/block--tips-list.html`
  - [ ] `post-tutorial/block--common-mistakes.html`
  - [ ] `post-tutorial/block--calculator-tool.html`

- [ ] Test with existing post:
  - [ ] Convert `2024-06-10-hitung-kebutuhan-kayu-dolken-untuk-proyek.md` to new template
  - [ ] Validate output matches current version
  - [ ] Check all blocks render correctly

### Phase 3: Comparison Template
- [ ] Create `TEMPLATE--post-comparison.md`
- [ ] Create comparison blocks:
  - [ ] `post-comparison/block--comparison-table.html`
  - [ ] `post-comparison/block--pros-cons.html`
  - [ ] `post-comparison/block--feature-matrix.html`
  - [ ] `post-comparison/block--recommendation.html`

- [ ] Test with existing post:
  - [ ] Convert `2024-03-05-perbedaan-kayu-gelam-dengan-kayu-lainnya.md`
  - [ ] Validate rendering
  - [ ] Check responsive design

### Phase 4: Guide Template
- [ ] Create `TEMPLATE--post-guide.md`
- [ ] Create guide blocks:
  - [ ] `post-guide/block--guide-sections.html`
  - [ ] `post-guide/block--best-practices.html`
  - [ ] `post-guide/block--quick-reference.html`
  - [ ] `post-guide/block--do-dont-list.html`

- [ ] Test with existing post:
  - [ ] Convert `2024-05-15-perawatan-kayu-dolken-gelam-agar-awet.md`
  - [ ] Validate all sections
  - [ ] Check mobile responsiveness

### Phase 5: Documentation & Migration
- [ ] Complete documentation:
  - [ ] Write detailed DOCS guide
  - [ ] Create quick README
  - [ ] Document all frontmatter fields
  - [ ] Add usage examples

- [ ] Migrate existing posts:
  - [ ] `2024-01-15-keunggulan-kayu-dolken-gelam-untuk-konstruksi.md`
  - [ ] `2024-02-10-cara-memilih-ukuran-kayu-dolken-yang-tepat.md`
  - [ ] All other posts in `_posts/`

- [ ] Validation:
  - [ ] Run build test: `./rebuild.sh`
  - [ ] Visual QA on all migrated posts
  - [ ] Check SEO structure (H2, H3, H4)
  - [ ] Verify Schema markup
  - [ ] Test mobile responsiveness

---

## 🎨 Design Principles

### 1. Reusability
- Blocks should be reusable across multiple posts
- No post-specific logic in shared blocks
- Use frontmatter for customization

### 2. Consistency
- All posts use same base structure
- Visual consistency across all content types
- Predictable user experience

### 3. Maintainability
- Update once, apply everywhere
- Clear file organization
- Well-documented code

### 4. Flexibility
- Mix and match blocks as needed
- Optional sections via `{% if %}`
- Extend templates easily

### 5. Performance
- WebP images by default
- Lazy loading for images
- Minimal JavaScript
- Optimize for Core Web Vitals

---

## 📊 Success Metrics

### Before Implementation:
- ❌ Each post has custom HTML structure
- ❌ Code duplication across posts
- ❌ Hard to maintain consistency
- ❌ Creating new post takes 2-3 hours
- ❌ Updates require editing multiple files

### After Implementation:
- ✅ All posts use standardized blocks
- ✅ Zero code duplication (DRY principle)
- ✅ Perfect consistency across all posts
- ✅ Creating new post takes 20-30 minutes
- ✅ Updates change one block file only
- ✅ New content types = new template (15 min)

---

## 🔗 Related Tasks

### Prerequisites:
- ✅ TODO-1537: Heading hierarchy refactoring (in progress)

### Detailed Specifications:
- [ ] **TODO-1538-yaml-schema-and-block-pattern.md** - YAML Schema & HTML Block Pattern

### Follow-up Tasks:
- [ ] TODO-1539: Auto-generate Table of Contents from headings
- [ ] TODO-1540: Schema markup for Article sections
- [ ] TODO-1541: SEO optimization for all templates
- [ ] TODO-1542: A/B testing framework for content blocks

---

## 📝 Migration Strategy

### Step 1: Create & Test Infrastructure
1. Build all templates and blocks
2. Test with 1 post per template type
3. Validate output quality

### Step 2: Pilot Migration (3 posts)
1. Choose 1 tutorial, 1 comparison, 1 guide
2. Migrate to new templates
3. Compare before/after metrics
4. Gather feedback

### Step 3: Full Migration
1. Migrate remaining posts in batches
2. Monitor site performance
3. Track SEO impact in Search Console

### Step 4: Documentation & Training
1. Complete all documentation
2. Create video walkthrough
3. Update team workflow

---

## 🚀 Next Steps

### Week 1: Foundation (Nov 20-26)
- [ ] Create folder structure
- [ ] Build TEMPLATE--post-base.md
- [ ] Create base blocks
- [ ] Write initial documentation

### Week 2: Tutorial Template (Nov 27 - Dec 3)
- [ ] Build TEMPLATE--post-tutorial.md
- [ ] Create tutorial blocks
- [ ] Test with existing post
- [ ] Refine based on feedback

### Week 3: Other Templates (Dec 4-10)
- [ ] Build comparison template
- [ ] Build guide template
- [ ] Test all templates
- [ ] Complete documentation

### Week 4: Migration (Dec 11-17)
- [ ] Migrate all existing posts
- [ ] Validation and QA
- [ ] Monitor metrics
- [ ] Iterate and improve

---

## 💡 Best Practices

### For Template Creation:
- Start with smallest viable template
- Test early and often
- Get feedback from content creators
- Iterate based on real usage

### For Block Design:
- Keep blocks focused (single responsibility)
- Use semantic HTML
- Accessible by default (ARIA labels)
- Mobile-first responsive design
- Performance optimized (lazy loading, WebP)

### For Documentation:
- Clear examples for each template
- Screenshot comparisons
- Common pitfalls and solutions
- Quick reference guide

---

## 📌 Important Notes

- **Backward Compatibility:** Existing custom post blocks in `_includes/posts/{post-name}/` remain untouched
- **Gradual Migration:** No need to migrate all at once, can be done incrementally
- **A/B Testing:** Consider keeping old version to compare performance
- **SEO Impact:** Monitor Search Console for any ranking changes
- **Performance:** Benchmark Core Web Vitals before and after
- **User Feedback:** Track engagement metrics (time on page, bounce rate)

---

## 🎯 Definition of Done

This TODO is complete when:
- [ ] All templates created and tested
- [ ] All blocks implemented and validated
- [ ] Complete documentation written
- [ ] At least 3 posts migrated successfully
- [ ] Build passes without errors
- [ ] SEO structure validated
- [ ] Mobile responsive confirmed
- [ ] Performance benchmarks met
- [ ] Team trained on new system
- [ ] Feedback incorporated

---

**Created:** 2025-11-20
**Last Updated:** 2025-11-20
**Next Review:** After Phase 1 completion
**Estimated Effort:** 4 weeks
**Impact:** High (affects all future content creation)
