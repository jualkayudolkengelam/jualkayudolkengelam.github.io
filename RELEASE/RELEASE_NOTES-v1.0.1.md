# Release Notes - v1.0.1

**Release Date:** 2025-11-17
**Project:** Jual Kayu Dolken Gelam Website
**Business:** Kayu Dolken Gelam - Amirudin Abdul Karim
**Type:** Patch Release - Documentation & Architecture Planning

---

## 📋 Summary

Version 1.0.1 adalah patch release yang fokus pada perencanaan arsitektur untuk meningkatkan maintainability dan scalability website melalui adopsi **Drupal-style naming convention** untuk Jekyll layouts dan components.

**Tidak ada perubahan pada kode production** - release ini hanya menambahkan dokumentasi perencanaan dan execution checklist.

---

## 🎯 What's New

### 📝 **Documentation - Architecture Planning**

#### TODO-1534: Drupal Naming Convention Migration (Planning)
**File:** `TODO/TODO-1534-drupal-naming-convention-migration.md`

Dokumen perencanaan komprehensif untuk migrasi naming convention:

**Current State (Inconsistent):**
```
_layouts/
├── default.html
├── post.html
├── post-with-products.html
└── product.html

_includes/
├── block--related-content--by-node.html
├── block--related-product--by-last-modified.html
├── block--product-list.html
└── block--carousel--image.html
```

**Target State (Drupal-style):**
```
_layouts/
├── page.html                        # Page wrapper (base)
├── page--front.html                 # Homepage wrapper (special layout)
├── node.html                        # Content template (base)
├── node--post.html                  # Blog post content
├── node--post-with-product.html     # Hybrid post content
└── node--product.html               # Product content

_includes/
├── block--related-content--by-node.html
├── block--related-product--by-last-modified.html
├── block--block--product-list.html
├── block--carousel--image.html
├── block--card--link.html
└── block--cta--whatsapp.html
```

**Key Concepts Documented:**

1. **Three-Tier Architecture:**
   - `page.html` - Page wrapper (header, footer, site structure)
   - `node.html` - Content template (article/product layout)
   - `block.html` - Reusable components (related content, product lists)

2. **Decision Matrix:**
   | Need | Use | Example |
   |------|-----|---------|
   | Different header/footer/wrapper | `page--*.html` | Homepage (hero, different footer) |
   | Different content layout only | `node--*.html` | Products vs Posts |
   | Same content, different sorting | `block--*--*.html` | Related products by-node vs by-last-modified |

3. **Real Examples from This Site:**
   - **Homepage NEEDS `page--front.html`** - Different site structure (hero, expanded footer)
   - **Products DON'T NEED `page--product.html`** - Same site structure, only content differs
   - Current analysis of `default.html` and `product.html` showing why this distinction matters

**Benefits:**
- ✅ Self-documenting file names
- ✅ Better organization and scalability
- ✅ Consistent naming pattern
- ✅ Easier to add new variants
- ✅ Clear hierarchy visible from names

---

#### TODO-1535: Drupal Naming Migration - Execution Checklist
**File:** `TODO/TODO-1535-drupal-naming-migration-execution.md`

Comprehensive step-by-step execution checklist dengan **913 lines** of detailed instructions:

**Structure:**

**Pre-Migration Checklist:**
- Safety & backup (git commit sebelum mulai)
- Create migration branch (optional)
- Document current file structure

**Phase 1: Layouts Migration (11 tasks)**
- Rename `default.html` → `page.html`
- Create `page--front.html` (homepage wrapper)
- Create `node.html` (base content template)
- Rename all layouts → `node--*.html` pattern
- Update all frontmatter `layout:` references
- Verification steps

**Phase 2: Blocks/Components Migration (4 sub-tasks)**
- Task 2.1: Related content blocks
- Task 2.2: Product blocks
- Task 2.3: UI blocks (carousel, cards)
- Task 2.4: Utility blocks (WhatsApp CTA)
- Each task: rename + update references + verify

**Phase 3: Testing & Validation (4 sub-tasks)**
- Task 3.1: Build testing (`bundle exec jekyll build`)
- Task 3.2: Visual testing (local server)
  - Test homepage, blog posts, products, static pages
- Task 3.3: Schema validation (Google Rich Results)
- Task 3.4: Link verification (RSS, sitemap)

**Phase 4: Documentation Updates**
- Add Drupal naming headers to all files
- Create/update NAMING-CONVENTION.md
- Update README if needed

**Phase 5: Commit & Finalize**
- Final verification (no old references)
- Create detailed migration commit
- Create migration summary document

**Special Features:**
- ✅ Complete bash commands for each step (copy-paste ready)
- ✅ Verification steps after each phase
- ✅ Rollback plan if migration fails (3 options)
- ✅ Testing checklist (build, visual, schema, links)
- ✅ Post-migration tasks (merge, deploy, documentation)

**Estimated Execution Time:** 8-12 hours

---

## 📂 Files Changed

### New Files
- ✅ `TODO/TODO-1534-drupal-naming-convention-migration.md` (761 lines)
- ✅ `TODO/TODO-1535-drupal-naming-migration-execution.md` (913 lines)
- ✅ `RELEASE/RELEASE_NOTES-v1.0.0.md` (archived from previous version)

### Modified Files
- ✅ `RELEASE_NOTES.md` (new content for v1.0.1)

---

## 🔄 Migration Status

**Current Status:** ⏸️ Planning Complete - Ready for Execution

**Dependencies:**
- ✅ TODO-1534 planning completed
- ✅ TODO-1535 execution checklist ready
- ⏳ Awaiting user approval to begin migration

**When Migration Executes:**
- All existing functionality will remain unchanged
- Better file organization for future development
- Easier onboarding for contributors
- Scalable architecture for adding new features

---

## 🎓 Key Learnings Documented

### Why Homepage Needs page--front.html BUT Products Don't

**Homepage (Different Site Structure):**
```html
<!-- page--front.html -->
<body class="homepage">
  <header class="transparent-header fixed">Logo | Menu</header>
  <section class="hero-full-width"><!-- Big hero --></section>
  <main class="no-sidebar full-width">{{ content }}</main>
  <footer class="expanded-footer"><!-- Newsletter, social --></footer>
</body>
```

**Products (Same Site Structure, Different Content):**
```yaml
# product.html frontmatter
---
layout: default  ← Wrapped by default.html!
---
<!-- Product content only -->
```

**Insight:** Products use same header/footer/whatsapp-button as other pages. Only content layout differs, so they need `node--product.html` (content template), NOT `page--product.html` (wrapper).

---

## 🛠️ Technical Details

### Pattern Structure
```
{entity-type}--{variant}.html
{entity-type}--{variant}--{sub-variant}.html
```

### Rules
1. **Base template** = fallback (e.g., `page.html`, `node.html`, `block.html`)
2. **Double dash `--`** = variant separator
3. **Specific > General** = cascade/specificity hierarchy
4. **Three-tier architecture** = page wraps node wraps block
5. **Alphabetically grouped** = better file organization

---

## 🔍 Impact Analysis

### Before Migration
**Problems:**
- ❌ No hierarchy - susah bedakan base vs variant
- ❌ Tidak konsisten - `post.html`, `product.html`, tapi base-nya `default.html`
- ❌ Tidak scalable - sulit tambah variants baru
- ❌ Components tidak terorganisir - `related-*`, `product-*` tercampur

### After Migration (Expected)
**Benefits:**
- ✅ Clear three-tier hierarchy: page > node > block
- ✅ Consistent naming across all files
- ✅ Easy to add variants: `block--product-list--featured.html`
- ✅ Self-documenting: `block--related-product--by-last-modified.html`
- ✅ Better searchability: `ls _includes/block--*product*`

---

## 📊 Statistics

**Total Lines of Documentation Added:** 1,674+ lines
- TODO-1534: 761 lines (planning)
- TODO-1535: 913 lines (execution)

**Files to be Migrated (When Executed):**
- Layouts: 4 renamed, 2 created = 6 total layout files
- Blocks: 8+ renamed to `block--*.html` pattern
- Content files: 13+ files (frontmatter updates)

**Zero Breaking Changes** (when properly executed)

---

## 🚀 What's Next?

### Immediate Next Steps
1. Review TODO-1534 for understanding the architecture
2. Review TODO-1535 for execution steps
3. Get user approval to begin migration
4. Execute migration following TODO-1535 checklist
5. Test thoroughly (build, visual, schema, links)
6. Deploy to production

### Future Enhancements (Still Pending)
From v1.0.0 TODO items:
- TODO-1531: Performance optimization strategies
- TODO-1532: Schema.org migration plan
- TODO-1533: Component-level schema implementation

**After migration completes**, these TODOs will be easier to implement with the new architecture.

---

## ⚠️ Important Notes

1. **This is a PLANNING release** - no code changes yet
2. **All current functionality intact** - website still works as v1.0.0
3. **Migration is optional** - can be executed when ready
4. **Rollback plan included** - safe to attempt migration
5. **Estimated time: 8-12 hours** - for complete migration

---

## 📞 Support

Untuk pertanyaan atau bantuan:
- WhatsApp: +62 813-1140-0177
- Website: https://jualkayudolkengelam.net

---

## 🙏 Credits

- **Planning & Documentation:** Claude Code AI Assistant
- **Business Owner:** Amirudin Abdul Karim
- **Framework:** Jekyll Static Site Generator
- **Architecture Pattern:** Drupal Twig Template Naming Convention

---

**Version:** 1.0.1
**Status:** Planning Complete ✅ - Ready for Execution
**Release Date:** 2025-11-17
**Previous Version:** 1.0.0 (archived in `RELEASE/RELEASE_NOTES-v1.0.0.md`)

---

## 📖 Version History

- **v1.0.1** (2025-11-17) - Architecture planning & documentation
- **v1.0.0** (2025-11-16) - Initial production release

---

**Next Release:** v1.0.2 or v1.1.0 (after migration execution)
- If migration succeeds → v1.1.0 (minor version bump for architecture change)
- If only bug fixes → v1.0.2 (patch version)

**Terima kasih!** 🌳
