# GitHub Actions Workflows - Complete Index

**Last Updated:** 2025-11-16

---

## 📁 Directory Structure

```
Repository Root
│
├── .github/workflows/          # Production workflows (active)
│   ├── jekyll.yml             # Deployment workflow
│   └── update-engagement.yml  # Cronjob workflow (weekly)
│
└── TODO/
    ├── workflows-backup/      # Backup & evaluation
    │   ├── README.md          # Complete documentation
    │   ├── CHANGELOG.md       # Change history
    │   ├── jekyll.yml.backup  # Deployment backup
    │   └── update-engagement.yml.backup  # Cronjob backup
    │
    ├── TODO-1527-github-actions-deployment-fix.md
    ├── TODO-1528-cronjob-engagement-update.md
    └── WORKFLOWS-INDEX.md     # This file
```

---

## 🎯 Quick Links

### Active Workflows (Production):

| Workflow | Location | Purpose | Status |
|----------|----------|---------|--------|
| **Deployment** | `.github/workflows/jekyll.yml` | Build & deploy Jekyll site | ✅ Active |
| **Cronjob** | `.github/workflows/update-engagement.yml` | Weekly engagement updates | ✅ Active |

### Backups & Documentation:

| Resource | Location | Purpose |
|----------|----------|---------|
| **Workflow Backups** | `TODO/workflows-backup/*.backup` | Safe copies for evaluation |
| **Usage Guide** | `TODO/workflows-backup/README.md` | How to use workflows |
| **Change Log** | `TODO/workflows-backup/CHANGELOG.md` | Track modifications |
| **Setup Docs** | `TODO/TODO-1527-*.md` | Deployment setup |
| **Cronjob Docs** | `TODO/TODO-1528-*.md` | Cronjob features |

---

## 🚀 Workflows Overview

### 1. Deployment Workflow (`jekyll.yml`)

**File:** `.github/workflows/jekyll.yml`
**Backup:** `TODO/workflows-backup/jekyll.yml.backup`

**Purpose:**
- Build Jekyll site with version 4.3.0
- Deploy to GitHub Pages
- Fix Jekyll version conflicts

**Triggers:**
- Push to `main` branch (automatic)
- Manual dispatch via Actions tab

**Status:** ✅ Running successfully

**Documentation:** `TODO/TODO-1527-github-actions-deployment-fix.md`

**Key Features:**
```yaml
- Ruby 3.0
- Bundle cache for faster builds
- Production environment
- Deploy to GitHub Pages
```

---

### 2. Cronjob Workflow (`update-engagement.yml`)

**File:** `.github/workflows/update-engagement.yml`
**Backup:** `TODO/workflows-backup/update-engagement.yml.backup`

**Purpose:**
- Auto-update engagement metrics
- Increment like counts weekly
- Keep content fresh

**Triggers:**
- Weekly: Every Monday at 00:00 UTC (07:00 WIB)
- Manual dispatch via Actions tab

**Status:** ✅ Active (next run: Monday)

**Documentation:** `TODO/TODO-1528-cronjob-engagement-update.md`

**Key Features:**
```yaml
- 30% probability per post
- Random increment (+1 to +3)
- Auto-commit & push
- Triggers deployment workflow
```

---

## 📋 How to Use This Index

### For Viewing Workflows:

**Production (Active):**
```bash
# Read deployment workflow
cat .github/workflows/jekyll.yml

# Read cronjob workflow
cat .github/workflows/update-engagement.yml
```

**Backup (For Evaluation):**
```bash
# Read deployment backup
cat TODO/workflows-backup/jekyll.yml.backup

# Read cronjob backup
cat TODO/workflows-backup/update-engagement.yml.backup

# Read complete documentation
cat TODO/workflows-backup/README.md
```

### For Editing Workflows:

**Safe Approach (Recommended):**
```bash
# 1. Edit backup first
nano TODO/workflows-backup/update-engagement.yml.backup

# 2. Review changes
cat TODO/workflows-backup/update-engagement.yml.backup

# 3. Copy to production when ready
cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml

# 4. Commit and push
git add .github/workflows/update-engagement.yml
git commit -m "feat: update workflow - [description]"
git push
```

**Direct Edit (For Minor Changes):**
```bash
# Edit production file directly
nano .github/workflows/update-engagement.yml

# Commit and push
git add .github/workflows/update-engagement.yml
git commit -m "fix: minor workflow adjustment"
git push

# Update backup
cp .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
git add TODO/workflows-backup/
git commit -m "docs: update workflow backup"
git push
```

---

## 🔍 Evaluation & Testing

### Evaluate Workflow Before Modifying:

**Read Documentation:**
```bash
# Complete guide
cat TODO/workflows-backup/README.md

# Specific workflow docs
cat TODO/TODO-1528-cronjob-engagement-update.md
```

**Check Git History:**
```bash
# See all changes to workflow
git log --oneline -- .github/workflows/update-engagement.yml

# See specific commit
git show 484e89c
```

**Compare Versions:**
```bash
# Compare production vs backup
diff .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
```

### Test Workflow Manually:

**Via GitHub Actions Tab:**
1. Go to: `https://github.com/[repo]/actions`
2. Click workflow name
3. Click "Run workflow" button
4. Select branch: `main`
5. Click "Run workflow"
6. Monitor execution

**Via Git Commit:**
```bash
# Make a test commit to trigger deployment
echo "<!-- test -->" >> kontak.html
git add kontak.html
git commit -m "test: trigger workflow"
git push

# Monitor at: https://github.com/[repo]/actions
```

---

## 📊 Workflow Status Monitoring

### Check Live Status:

**GitHub Actions Tab:**
```
https://github.com/jualkayudolkengelam/jualkayudolkengelam.github.io/actions
```

**Via Command Line:**
```bash
# Check latest commits that triggered workflows
git log --oneline -5

# See what files changed
git log --oneline --name-status -5
```

### Monitor Cronjob:

**Next Scheduled Run:**
- Day: Monday
- Time: 00:00 UTC (07:00 WIB)
- Frequency: Weekly

**Check Last Run:**
```bash
# Go to Actions → Update Engagement Metrics
# See run history and logs
```

---

## 🛠️ Common Tasks

### Task 1: Update Cronjob Schedule

**File:** `TODO/workflows-backup/update-engagement.yml.backup`

**Change:**
```yaml
# From weekly to daily
schedule:
  - cron: '0 0 * * *'  # Daily
```

**Steps:**
1. Edit backup file
2. Copy to `.github/workflows/`
3. Commit and push
4. Verify in Actions tab

### Task 2: Change Increment Range

**Location:** Lines 30-31 in workflow

**Current:**
```bash
increment=$((RANDOM % 3 + 1))  # +1 to +3
```

**Options:**
```bash
# More aggressive
increment=$((RANDOM % 5 + 1))  # +1 to +5

# More subtle
increment=1  # Always +1

# Custom range
increment=$((RANDOM % 10 + 5))  # +5 to +14
```

### Task 3: Add Comment/Share Updates

**Add After Like Update:**
```bash
# Update comments occasionally (20% chance)
if [ $((RANDOM % 10)) -lt 2 ]; then
  current_comments=$(grep "^comment_count:" "$post" | awk '{print $2}')
  if [ -n "$current_comments" ]; then
    new_comments=$((current_comments + 1))
    sed -i "s/^comment_count: $current_comments/comment_count: $new_comments/" "$post"
  fi
fi
```

### Task 4: Restore from Backup

**If Production Workflow Broken:**
```bash
# Restore from backup
cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml

# Commit and push
git add .github/workflows/update-engagement.yml
git commit -m "fix: restore workflow from backup"
git push
```

---

## 📚 Related Documentation

### Must-Read Files:

1. **`TODO/workflows-backup/README.md`**
   - Complete workflow documentation
   - Usage guide
   - Troubleshooting
   - Development process

2. **`TODO/TODO-1527-github-actions-deployment-fix.md`**
   - Why we use custom workflows
   - Deployment setup steps
   - Fixing Jekyll version conflicts

3. **`TODO/TODO-1528-cronjob-engagement-update.md`**
   - Cronjob features
   - Configuration options
   - Benefits and use cases
   - Advanced customizations

4. **`TODO/workflows-backup/CHANGELOG.md`**
   - History of all workflow changes
   - Template for documenting changes

---

## 🔐 Security & Best Practices

### Secrets Management:
```yaml
# Use GitHub Secrets, not hardcoded values
token: ${{ secrets.GITHUB_TOKEN }}

# Never commit:
- API keys
- Passwords
- Personal access tokens
```

### Permissions:
```yaml
# Grant only what's needed
permissions:
  contents: write   # For committing
  pages: write      # For deployment
```

### Testing:
- [ ] Always test with manual trigger first
- [ ] Review logs for errors
- [ ] Monitor first automatic run
- [ ] Update backup after successful change

---

## 🆘 Troubleshooting

### Workflow Not Running:

1. **Check file location:**
   ```bash
   ls -la .github/workflows/
   ```

2. **Verify YAML syntax:**
   ```bash
   cat .github/workflows/update-engagement.yml
   ```

3. **Check GitHub Actions enabled:**
   - Go to Settings → Actions → Enable

4. **Check permissions:**
   - Settings → Actions → Workflow permissions

### Workflow Failing:

1. **Read error logs:**
   - Actions tab → Click failed run → Expand steps

2. **Compare with backup:**
   ```bash
   diff .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup
   ```

3. **Check recent changes:**
   ```bash
   git log -p -- .github/workflows/update-engagement.yml
   ```

4. **Rollback if needed:**
   ```bash
   git revert [commit-hash]
   # OR
   cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml
   ```

---

## 📞 Support Resources

### GitHub Actions Documentation:
- https://docs.github.com/en/actions

### Jekyll Documentation:
- https://jekyllrb.com/docs/

### Cron Schedule:
- https://crontab.guru/

### YAML Syntax:
- https://yaml.org/spec/

---

## 🎯 Quick Reference

### File Locations Summary:

```
Production Workflows:
  .github/workflows/jekyll.yml           ← Deployment
  .github/workflows/update-engagement.yml ← Cronjob

Backups:
  TODO/workflows-backup/jekyll.yml.backup
  TODO/workflows-backup/update-engagement.yml.backup

Documentation:
  TODO/workflows-backup/README.md        ← Main guide
  TODO/WORKFLOWS-INDEX.md                ← This file
  TODO/TODO-1527-*.md                    ← Deployment docs
  TODO/TODO-1528-*.md                    ← Cronjob docs

History:
  TODO/workflows-backup/CHANGELOG.md     ← Change log
```

### Commands Quick Reference:

```bash
# View workflow
cat .github/workflows/update-engagement.yml

# Edit backup
nano TODO/workflows-backup/update-engagement.yml.backup

# Deploy to production
cp TODO/workflows-backup/update-engagement.yml.backup .github/workflows/update-engagement.yml

# Compare versions
diff .github/workflows/update-engagement.yml TODO/workflows-backup/update-engagement.yml.backup

# Check history
git log --oneline -- .github/workflows/

# Test manually
# Go to GitHub → Actions → Run workflow
```

---

**Maintained By:** Development Team
**Created:** 2025-11-16
**Last Updated:** 2025-11-16
**Status:** Active & Documented
