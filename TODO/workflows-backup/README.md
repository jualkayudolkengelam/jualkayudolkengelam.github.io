# GitHub Actions Workflows Backup & Documentation

**Directory:** `TODO/workflows-backup/`
**Purpose:** Backup dan dokumentasi workflows untuk evaluasi dan development

---

## Files in This Directory

### Active Workflows (Backed Up from `.github/workflows/`)

1. **update-engagement.yml.backup**
   - **Original:** `.github/workflows/update-engagement.yml`
   - **Function:** Weekly auto-update engagement metrics (likes, comments, shares)
   - **Schedule:** Every Monday at 00:00 UTC (07:00 WIB)
   - **Status:** Active
   - **Last Updated:** 2025-11-16

2. **jekyll.yml.backup**
   - **Original:** `.github/workflows/jekyll.yml`
   - **Function:** Build and deploy Jekyll site to GitHub Pages
   - **Trigger:** Push to main branch + manual dispatch
   - **Status:** Active & Running Successfully
   - **Last Updated:** 2025-11-16

---

## Why This Directory Exists

### 1. **Version Control & History**
- Keep snapshots of working workflows
- Easy rollback if needed
- Compare versions when making changes

### 2. **Evaluation & Testing**
- Safe place to test modifications
- Review workflow logic before deploying
- Share with team for review

### 3. **Documentation**
- Reference for understanding workflow structure
- Examples for creating new workflows
- Training material

### 4. **Disaster Recovery**
- Backup if `.github/workflows/` accidentally deleted
- Quick restore capability
- Independent from git history

---

## Workflow File Locations

### Production (Active):
```
.github/workflows/
├── jekyll.yml              # Deployment workflow
└── update-engagement.yml   # Cronjob workflow
```

### Backup (This Directory):
```
TODO/workflows-backup/
├── README.md
├── jekyll.yml.backup
└── update-engagement.yml.backup
```

### Documentation:
```
TODO/
├── TODO-1527-github-actions-deployment-fix.md
└── TODO-1528-cronjob-engagement-update.md
```

---

## How to Use This Backup

### Restore a Workflow:
```bash
# If .github/workflows/update-engagement.yml is lost or broken
cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml
git add .github/workflows/update-engagement.yml
git commit -m "restore: update-engagement workflow from backup"
git push
```

### Compare Versions:
```bash
# See what changed
diff .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
```

### Test Modified Version:
```bash
# 1. Edit backup file
nano TODO/workflows-backup/update-engagement.yml.backup

# 2. Test locally (if possible)
# 3. Copy to production when ready
cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml
```

---

## Maintenance

### When to Update Backups:

**Update backup whenever production workflow changes:**
```bash
# After modifying workflow
cp .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
git add TODO/workflows-backup/
git commit -m "docs: update workflow backup after changes"
```

**Automated Backup (Optional):**
Could add to update-engagement.yml:
```yaml
- name: Backup workflow
  run: |
    cp .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
    git add TODO/workflows-backup/
```

---

## Evaluation Checklist

### Before Modifying Production Workflow:

- [ ] **Backup current version** to this directory
- [ ] **Document changes** in commit message
- [ ] **Test locally** if possible
- [ ] **Review syntax** (YAML validation)
- [ ] **Check permissions** (secrets, tokens)
- [ ] **Test with manual trigger** first
- [ ] **Monitor first run** in Actions tab
- [ ] **Update backup** after successful change

---

## Workflow Development Process

### Recommended Workflow:

1. **Edit Backup File:**
   ```bash
   nano TODO/workflows-backup/update-engagement.yml.backup
   ```

2. **Review Changes:**
   ```bash
   cat TODO/workflows-backup/update-engagement.yml.backup
   ```

3. **Test Syntax (Optional):**
   ```bash
   # Use YAML linter if available
   yamllint TODO/workflows-backup/update-engagement.yml.backup
   ```

4. **Deploy to Production:**
   ```bash
   cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml
   git add .github/workflows/update-engagement.yml
   git commit -m "feat: update workflow - [describe changes]"
   git push
   ```

5. **Monitor Results:**
   - Go to GitHub Actions tab
   - Watch first run
   - Check logs for errors

6. **Update Backup:**
   ```bash
   # If successful, backup is already up to date
   # If rolled back, restore from this backup
   ```

---

## Git History vs Backup

### Git History (Primary):
- **Advantage:** Full version control, diffs, blame, rollback
- **Location:** `.git/` database
- **Access:** `git log`, `git show`, `git checkout`

### This Backup (Secondary):
- **Advantage:** Quick access, easy to view, side-by-side comparison
- **Location:** `TODO/workflows-backup/` (visible in file tree)
- **Access:** Direct file read, copy, edit

**Use Both:** Git for history, this backup for quick reference and testing.

---

## Related Documentation

| File | Purpose |
|------|---------|
| `TODO-1527-github-actions-deployment-fix.md` | Deployment workflow setup & troubleshooting |
| `TODO-1528-cronjob-engagement-update.md` | Cronjob workflow features & configuration |
| `.github/workflows/jekyll.yml` | Production deployment workflow |
| `.github/workflows/update-engagement.yml` | Production cronjob workflow |

---

## Example: Modify Cron Schedule

### Current (in backup):
```yaml
schedule:
  - cron: '0 0 * * 1'  # Weekly Monday
```

### To Change to Daily:
```yaml
schedule:
  - cron: '0 0 * * *'  # Daily
```

### Steps:
1. Edit `update-engagement.yml.backup`
2. Change cron expression
3. Copy to `.github/workflows/update-engagement.yml`
4. Commit and push
5. Verify in Actions tab

---

## Example: Change Increment Range

### Current:
```bash
increment=$((RANDOM % 3 + 1))  # +1 to +3
```

### To Make More Aggressive:
```bash
increment=$((RANDOM % 5 + 1))  # +1 to +5
```

### To Make More Subtle:
```bash
increment=1  # Always +1
```

---

## Troubleshooting

### Workflow Not Running:
1. Check `.github/workflows/` has the file (not just backup)
2. Verify YAML syntax is valid
3. Check GitHub Actions is enabled in repo settings
4. Review workflow permissions

### Workflow Failing:
1. Check Actions tab for error logs
2. Compare with backup (working version)
3. Review recent changes with `git diff`
4. Test with manual trigger
5. Rollback if needed

---

## Security Notes

### Sensitive Data:
- ❌ **NEVER** commit tokens/secrets to workflow files
- ✅ **USE** `${{ secrets.GITHUB_TOKEN }}` for auth
- ✅ **USE** GitHub Secrets for API keys

### Permissions:
```yaml
permissions:
  contents: write  # Only if workflow needs to commit
  pages: write     # Only for deployment
  id-token: write  # For OIDC
```

**Principle of Least Privilege:** Only grant permissions actually needed.

---

## Future Workflows (Ideas)

### Potential Additions:
1. **update-products.yml** - Weekly product stock/price updates
2. **generate-sitemap.yml** - Monthly sitemap regeneration
3. **optimize-images.yml** - Auto-compress new images
4. **check-links.yml** - Validate internal/external links
5. **backup-content.yml** - Backup posts to external storage

**Store templates in this directory for future use!**

---

**Last Updated:** 2025-11-16
**Maintained By:** Development Team
**Status:** Active & Monitored
