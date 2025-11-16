# TODO-1528: Cronjob Workflow for Post Metrics Updates

**Date:** 2025-11-16
**Status:** 📋 Optional Enhancement
**Type:** Automation - Scheduled Workflow

---

## Task Summary

Setup GitHub Actions cronjob workflow untuk auto-update post metrics (like, comment, share counts) secara berkala, mensimulasikan aktivitas user dan menjaga konten tetap terlihat fresh.

---

## Relationship with Deployment Workflow

### **Workflow Architecture:**

```
┌──────────────────────────────────────────────┐
│  Cronjob Workflow (update-post-metrics.yml)  │
│  ─────────────────────────────────────────   │
│  Trigger: Scheduled (daily at midnight)      │
│  Actions:                                    │
│  1. Checkout repository                      │
│  2. Update post metrics in _posts/           │
│  3. Commit changes                           │
│  4. Push to main branch                      │
└──────────────┬───────────────────────────────┘
               │
               │ git push triggers...
               │
               ↓
┌──────────────────────────────────────────────┐
│  Deployment Workflow (jekyll.yml)            │
│  ──────────────────────────────────────      │
│  Trigger: Push to main (from cronjob)        │
│  Actions:                                    │
│  1. Build Jekyll site with new metrics       │
│  2. Deploy to GitHub Pages                   │
│  3. Site goes live with updated counts       │
└──────────────────────────────────────────────┘
```

**Result:** Post metrics auto-update daily, site auto-rebuilds dan deploy!

---

## Use Cases

### **1. Post Metrics Simulation**
- **Like counts** - Increment by 0-3 randomly
- **Comment counts** - Increment by 0-1 occasionally
- **Share counts** - Increment by 0-2 occasionally

**Why?**
- ✅ Social proof - Higher numbers build trust
- ✅ SEO signals - Fresh content gets better ranking
- ✅ User psychology - Popular posts attract more clicks

### **2. Content Freshness**
- **last_modified_at** - Update selected posts
- **Sitemap** - Auto-regenerates with new dates
- **Feeds** - Stay current

**Why?**
- ✅ Google favors recently updated content
- ✅ "Fresh" label in search results
- ✅ Higher CTR from search

### **3. Dynamic Content**
- **Stock status** - "Tersedia" / "Stok Terbatas"
- **Seasonal badges** - "Promo Ramadan", "Diskon Tahun Baru"
- **Trending markers** - Auto-add "🔥 Trending" to popular posts

---

## Workflow Features

### **File Created:**
`.github/workflows/update-post-metrics.yml`

### **Triggers:**
1. **Scheduled:** Twice per week for organic timing variation
   - Monday 00:00 UTC (07:00 WIB)
   - Thursday 02:30 UTC (09:30 WIB)
2. **Manual:** Via Actions tab (workflow_dispatch)

### **Permissions:**
```yaml
permissions:
  contents: write  # Required for git push
```

**Why needed:**
- ✅ Allows github-actions[bot] to commit changes
- ✅ Enables pushing to main branch
- ✅ Prevents exit code 128 (403 Permission denied)

### **What It Does:**

#### **Step 1: Update Metrics**
```bash
# For each post in _posts/
- Random chance (30%) to update
- Increment like_count by 1-3
- Could extend to comments/shares
```

#### **Step 2: Check Changes**
```bash
# Only commit if files actually changed
- Prevents empty commits
- Clean git history
```

#### **Step 3: Commit & Push**
```bash
# Automated commit
- Author: github-actions[bot]
- Message: "chore: auto-update post metrics"
- Push to main → Triggers deployment
```

### **Safety Features:**
- ✅ Only updates if changes detected
- ✅ Descriptive commit messages
- ✅ Bot author attribution
- ✅ No manual intervention needed

---

## Example Weekly Run

### **07:00 WIB (Every Monday):**

```
1. Cronjob triggers
   ↓
2. Scans all posts in _posts/
   ↓
3. Finds 3 posts to update:
   - jual-kayu-dolken-terdekat.md: 7 → 9 likes (+2)
   - aplikasi-kayu-dolken-hotel.md: 92 → 94 likes (+2)
   - perawatan-kayu-dolken.md: 45 → 46 likes (+1)
   ↓
4. Commits: "chore: auto-update post metrics"
   ↓
5. Pushes to main
   ↓
6. Triggers deployment workflow (jekyll.yml)
   ↓
7. Site rebuilds with new metrics
   ↓
8. Deploys to GitHub Pages
   ↓
9. ✅ Live site shows updated post metrics!
```

**Total time:** ~5 minutes
**User action required:** None (fully automated)

---

## Configuration Options

### **Update Frequency:**

**Current:** Twice per week
- Monday 00:00 UTC (07:00 WIB)
- Thursday 02:30 UTC (09:30 WIB)
```yaml
schedule:
  - cron: '0 0 * * 1'   # Monday 00:00 UTC (07:00 WIB)
  - cron: '30 2 * * 4'  # Thursday 02:30 UTC (09:30 WIB)
```

**Options:**
```yaml
# Daily at midnight
- cron: '0 0 * * *'

# Twice weekly (Monday and Thursday)
- cron: '0 0 * * 1,4'

# Bi-weekly (every 2 weeks on Monday)
- cron: '0 0 */14 * 1'

# Monthly (1st day of month)
- cron: '0 0 1 * *'
```

### **Update Probability:**

**Current:** 30% chance per post
```bash
if [ $((RANDOM % 10)) -lt 3 ]; then
```

**Adjust:**
```bash
# 50% chance
if [ $((RANDOM % 10)) -lt 5 ]; then

# 10% chance (subtle)
if [ $((RANDOM % 10)) -lt 1 ]; then

# 100% (all posts, every run)
if true; then
```

### **Increment Amount:**

**Current:** +1 to +3 randomly
```bash
increment=$((RANDOM % 3 + 1))
```

**Adjust:**
```bash
# +1 only (subtle growth)
increment=1

# +1 to +5 (faster growth)
increment=$((RANDOM % 5 + 1))

# Fixed +2
increment=2
```

---

## Advanced Features (Optional)

### **1. Smart Updates Based on Post Age:**

```bash
# Newer posts get more engagement
post_date=$(grep "^date:" "$post" | awk '{print $2}')
days_old=$((($(date +%s) - $(date -d "$post_date" +%s)) / 86400))

if [ $days_old -lt 30 ]; then
  # Recent post: higher increment
  increment=$((RANDOM % 5 + 2))
else
  # Older post: subtle increment
  increment=$((RANDOM % 2 + 1))
fi
```

### **2. Update Multiple Metrics:**

```bash
# Update likes
current_likes=$(grep "^like_count:" "$post" | awk '{print $2}')
new_likes=$((current_likes + increment))
sed -i "s/^like_count: $current_likes/like_count: $new_likes/" "$post"

# Update comments occasionally
if [ $((RANDOM % 10)) -lt 2 ]; then
  current_comments=$(grep "^comment_count:" "$post" | awk '{print $2}')
  new_comments=$((current_comments + 1))
  sed -i "s/^comment_count: $current_comments/comment_count: $new_comments/" "$post"
fi

# Update shares occasionally
if [ $((RANDOM % 10)) -lt 2 ]; then
  current_shares=$(grep "^share_count:" "$post" | awk '{print $2}')
  new_shares=$((current_shares + 1))
  sed -i "s/^share_count: $current_shares/share_count: $new_shares/" "$post"
fi
```

### **3. Add Trending Badges:**

```bash
# Mark posts with 50+ likes as trending
likes=$(grep "^like_count:" "$post" | awk '{print $2}')

if [ $likes -ge 50 ]; then
  # Add trending badge to title if not already there
  if ! grep -q "🔥" "$post"; then
    sed -i 's/^title: "\(.*\)"/title: "🔥 \1"/' "$post"
  fi
fi
```

### **4. Update last_modified_at:**

```bash
# Always update last_modified_at when metrics change
current_date=$(date +%Y-%m-%d)

if grep -q "^last_modified_at:" "$post"; then
  sed -i "s/^last_modified_at: .*/last_modified_at: $current_date/" "$post"
else
  # Add if doesn't exist
  sed -i "/^date:/a last_modified_at: $current_date" "$post"
fi
```

---

## Testing

### **Manual Trigger (Recommended First):**

1. Go to: `https://github.com/jualkayudolkengelam/jualkayudolkengelam.github.io/actions`
2. Click "Update Post Metrics" workflow
3. Click "Run workflow" dropdown
4. Click "Run workflow" button
5. Wait 1-2 minutes
6. Check commit history for auto-update

### **Check Results:**

```bash
# Local: Pull latest changes
git pull origin main

# Check which files changed
git log -1 --stat

# See the diff
git log -1 -p
```

---

## Monitoring

### **View Workflow Runs:**
```
GitHub → Actions → Update Post Metrics
```

**Check for:**
- ✅ Green checkmark (success)
- 📊 Number of posts updated
- 📝 Commit created
- 🚀 Deployment triggered

### **Workflow Logs:**

Click on a run to see:
- Which posts were updated
- Old → New values
- Whether changes were committed
- Deploy status

---

## Benefits

### **SEO:**
- ✅ Regular content updates
- ✅ Fresh content signals
- ✅ Better search rankings
- ✅ Sitemap stays current

### **User Trust:**
- ✅ Social proof (higher numbers)
- ✅ Popular content stands out
- ✅ Encourages engagement
- ✅ Professional appearance

### **Automation:**
- ✅ Zero manual work
- ✅ Consistent updates
- ✅ Scheduled reliability
- ✅ Hands-free operation

### **Flexibility:**
- ✅ Easy to customize
- ✅ Adjustable frequency
- ✅ Configurable increments
- ✅ Extensible for new features

---

## Costs

**GitHub Actions Free Tier:**
- ✅ 2,000 minutes/month FREE for public repos
- ✅ This workflow: ~1 minute/week = 4 minutes/month
- ✅ Well within free tier!

**No additional costs!**

---

## Risks & Mitigations

### **Risk 1: Unrealistic Growth**
**Problem:** Likes grow too fast, looks fake
**Mitigation:**
- Use low probability (10-30%)
- Small increments (+1 to +3)
- Age-based adjustment

### **Risk 2: Commit Spam**
**Problem:** Too many automated commits
**Mitigation:**
- Only commit if changes detected
- Descriptive commit messages
- Consider weekly instead of daily

### **Risk 3: Merge Conflicts**
**Problem:** Auto-commits conflict with manual edits
**Mitigation:**
- Schedule during low-activity hours
- Bot only touches post metrics
- Manual edits won't conflict

---

## Optional: Disable Cronjob

If you want to pause/disable:

### **Option 1: Delete Workflow File**
```bash
git rm .github/workflows/update-post-metrics.yml
git commit -m "chore: disable post metrics auto-update"
git push
```

### **Option 2: Disable in GitHub UI**
```
Settings → Actions → Disable workflow
```

### **Option 3: Comment Out Schedule**
```yaml
on:
  # schedule:
  #   - cron: '0 0 * * *'
  workflow_dispatch:  # Keep manual trigger
```

---

## Related Workflows

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| **Deployment** | `jekyll.yml` | Push to main | Build & deploy site |
| **Post Metrics Update** | `update-post-metrics.yml` | Daily cron | Update metrics |
| **(Future)** | `update-product-metrics.yml` | Weekly cron | Update product metrics |
| **(Future)** | `generate-sitemap.yml` | Monthly cron | Refresh sitemap |

---

## Installation

### **Option 1: Use As-Is (Recommended)**

```bash
# File already created
git add .github/workflows/update-post-metrics.yml
git add TODO/TODO-1528-cronjob-update-post-metrics.md
git commit -m "feat: add automated post metrics update workflow

- Twice per week cronjob (Mon 07:00 & Thu 09:30 WIB)
- Auto-increment like counts (30% probability, +1 to +3)
- Organic timing variation for natural appearance
- Triggers deployment workflow on push
- Fully automated, zero maintenance"
git push
```

### **Option 2: Customize First**

Edit `.github/workflows/update-post-metrics.yml`:
- Adjust cron schedule
- Change probability
- Modify increment range
- Add comment/share updates

**⚠️ IMPORTANT:** Ensure workflow includes permissions:
```yaml
permissions:
  contents: write  # Required for git push
```
Without this, workflow will fail with exit code 128 (Permission denied)

Then commit.

### **Option 3: Skip for Now**

Don't commit the file - it won't run. You can add it later when needed.

---

## Notes

- Cronjob workflow is **INDEPENDENT** from deployment workflow
- Both can run simultaneously without conflicts
- Deployment workflow will **automatically trigger** when cronjob pushes changes
- This creates a **fully automated content refresh system**
- No manual intervention needed after initial setup
- Can be disabled/paused anytime without affecting deployment

---

**Status:** 📋 Optional - File Created, Ready to Use
**Impact:** Automation - Keeps content fresh with zero manual work

**Recommendation:** Test with manual trigger first, then enable scheduled runs if satisfied!
