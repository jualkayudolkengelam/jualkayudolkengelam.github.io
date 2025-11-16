# Workflows Changelog

Track all changes to GitHub Actions workflows.

---

## 2025-11-16

### Initial Setup

**Created Workflows:**

1. **jekyll.yml** (Deployment)
   - Commit: `d216d33`
   - Purpose: Fix Jekyll 4.3.0 deployment issues
   - Status: ✅ Active & Running
   - Trigger: Push to main + manual
   - Result: Resolved 10+ failed deployments

2. **update-engagement.yml** (Cronjob)
   - Commit: `484e89c`
   - Purpose: Auto-update engagement metrics weekly
   - Status: ✅ Active (will run next Monday)
   - Trigger: Weekly (Monday 07:00 WIB) + manual
   - Function: Increment like counts randomly

**Backup Created:**
- Directory: `TODO/workflows-backup/`
- Files backed up: 2 workflows
- Documentation: README.md, CHANGELOG.md

---

## 2025-11-16 (Later)

### Workflow Reorganization & Product Metrics Implementation

**Change:** Major restructure - Split engagement into Posts and Products
**Reason:** Clarify separation between blog post metrics and product metrics
**Modified By:** Development Team

**Details:**

**1. Renamed: update-engagement.yml → update-post-metrics.yml**
- Changed: Workflow name for clarity
- Purpose: Now specifically handles `_posts/` metrics (like, comment, share)
- Target: Blog post engagement metrics only
- Commit message: "chore: auto-update post metrics"
- Status: ✅ Active

**2. Created: update-product-metrics.yml** ⭐ NEW
- Purpose: Handle `_products/` metrics (review_count, rating, popular)
- Features:
  - Smart aging algorithm (60%/40%/20% based on review count)
  - Auto-adjust ratings (±0.1 every 10 reviews, keep 4.5-5.0)
  - Auto-set popular flag (reviews > 80)
  - Rate limiting (max +5 reviews/week)
  - Update last_modified_at for SEO
  - Track total_updates counter
- Target: Product pages only
- Trigger: Weekly (Monday 00:00 UTC)
- Status: ✅ Active

**3. Documentation Updates:**
- Renamed: `TODO-1528-cronjob-engagement-update.md` → `TODO-1528-cronjob-update-post-metrics.md`
- Created: `TODO-1529-cronjob-update-product-metrics.md` (627 lines, comprehensive)
- Deleted: `WORKFLOWS-INDEX.md` (redundant, info in TODO docs)
- Updated: All internal references from "engagement" to "post metrics"

**Testing:**
- [x] Workflows validated (YAML syntax correct)
- [ ] Manual trigger test pending
- [ ] First automatic run pending (next Monday)
- [x] Documentation reviewed

**Impact:**
- ✅ Better separation of concerns (posts vs products)
- ✅ More realistic product growth patterns
- ✅ SEO benefits (fresh content signals)
- ✅ Cleaner documentation structure
- ⚠️ Breaking: Old "update-engagement.yml" no longer exists

**Files Changed:**
```
Renamed:
  .github/workflows/update-engagement.yml → update-post-metrics.yml
  TODO/TODO-1528-cronjob-engagement-update.md → TODO-1528-cronjob-update-post-metrics.md

Created:
  .github/workflows/update-product-metrics.yml
  TODO/TODO-1529-cronjob-update-product-metrics.md

Deleted:
  TODO/WORKFLOWS-INDEX.md
```

**Smart Features Implemented (Product Metrics):**
1. ✅ Smart Aging Algorithm - New products get more reviews
2. ✅ Multiple Metrics Update - Review count + rating + popular flag
3. ✅ Popular Badge Auto-Assignment - Auto-set when reviews > 80
4. ✅ Last Modified Update - SEO freshness signals
5. ✅ Rate Limiting - Prevent unrealistic growth (max +5/week)
6. ✅ Dynamic Rating Adjustment - Realistic variations (4.5-5.0)

---

## Change Log Format

### Template for Future Changes:

```markdown
## YYYY-MM-DD

### Workflow: [filename.yml]

**Change:** [Brief description]
**Reason:** [Why this change was made]
**Modified By:** [Name/Username]
**Commit:** [commit hash]

**Details:**
- Changed: [specific changes]
- Added: [new features]
- Removed: [deprecated features]
- Fixed: [bug fixes]

**Testing:**
- [ ] Tested manually via workflow_dispatch
- [ ] Verified successful run
- [ ] Checked logs for errors
- [ ] Updated backup

**Impact:**
- [What this change affects]
- [Any breaking changes]
- [Performance improvements]
```

---

## Planned Changes

### Future Enhancements:

**update-engagement.yml:**
- [ ] Add comment_count updates
- [ ] Add share_count updates
- [ ] Implement smart aging (newer posts get more engagement)
- [ ] Add trending badge for popular posts
- [ ] Update last_modified_at when engagement changes

**New Workflows:**
- [x] `update-product-metrics.yml` - Weekly product metrics updates ✅ COMPLETED
- [ ] `optimize-images.yml` - Auto image compression
- [ ] `check-links.yml` - Broken link checker
- [ ] `backup-content.yml` - Content backup automation

---

## Version History

| Version | Date | Workflows | Status |
|---------|------|-----------|--------|
| 1.0 | 2025-11-16 | jekyll.yml, update-engagement.yml | ⚠️ Deprecated |
| 2.0 | 2025-11-16 | jekyll.yml, update-post-metrics.yml, update-product-metrics.yml | ✅ Active |

**Version 2.0 Changes:**
- Renamed: update-engagement.yml → update-post-metrics.yml
- Added: update-product-metrics.yml (new)
- Documentation: TODO-1528 (posts), TODO-1529 (products)

---

**Maintained By:** Development Team
**Last Updated:** 2025-11-16
