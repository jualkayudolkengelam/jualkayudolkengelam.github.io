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
- [ ] `update-products.yml` - Weekly product updates
- [ ] `optimize-images.yml` - Auto image compression
- [ ] `check-links.yml` - Broken link checker
- [ ] `backup-content.yml` - Content backup automation

---

## Version History

| Version | Date | Workflows | Status |
|---------|------|-----------|--------|
| 1.0 | 2025-11-16 | jekyll.yml, update-engagement.yml | ✅ Active |

---

**Maintained By:** Development Team
**Last Updated:** 2025-11-16
