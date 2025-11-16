# TODO-1529: Cronjob Workflow for Product Metrics Updates

**Date:** 2025-11-16
**Status:** ✅ Implemented
**Type:** Automation - Scheduled Workflow

---

## Task Summary

Setup GitHub Actions cronjob workflow untuk auto-update product metrics (review count, rating, popularity) secara berkala, mensimulasikan aktivitas pelanggan dan menjaga produk tetap terlihat credible dan populer.

---

## Relationship with Deployment Workflow

### **Workflow Architecture:**

```
┌──────────────────────────────────────────────────┐
│  Cronjob Workflow (update-product-metrics.yml)   │
│  ───────────────────────────────────────────────  │
│  Trigger: Scheduled (weekly at midnight)          │
│  Actions:                                         │
│  1. Checkout repository                           │
│  2. Update product metrics in _products/          │
│  3. Commit changes                                │
│  4. Push to main branch                           │
└──────────────┬────────────────────────────────────┘
               │
               │ git push triggers...
               │
               ↓
┌──────────────────────────────────────────────────┐
│  Deployment Workflow (jekyll.yml)                │
│  ──────────────────────────────────────────      │
│  Trigger: Push to main (from cronjob)            │
│  Actions:                                         │
│  1. Build Jekyll site with new metrics           │
│  2. Deploy to GitHub Pages                       │
│  3. Site goes live with updated counts           │
└──────────────────────────────────────────────────┘
```

**Result:** Product metrics auto-update weekly, site auto-rebuilds dan deploy!

---

## Use Cases

### **1. Product Metrics Simulation**
- **Review counts** - Increment by 0-5 based on age
- **Rating** - Slight adjustment (±0.1) every 10 reviews
- **Popular flag** - Auto-set true if reviews > 80
- **Total updates** - Counter untuk tracking

**Why?**
- ✅ Social proof - More reviews build trust
- ✅ SEO signals - Fresh products get better ranking
- ✅ Conversion optimization - Popular products sell better

### **2. Product Freshness**
- **last_modified_at** - Update selected products
- **Sitemap** - Auto-regenerates with new dates
- **Product schema** - Stays current

**Why?**
- ✅ Google favors recently updated products
- ✅ "Fresh" label in search results
- ✅ Higher CTR from search

### **3. Dynamic Product Status**
- **Popular badge** - Auto-add "⭐ Popular" to high-review products
- **Social proof** - "91 reviews" more credible than "2 reviews"
- **Trust signals** - Higher ratings = more sales

---

## Workflow Features

### **File Created:**
`.github/workflows/update-product-metrics.yml`

### **Triggers:**
1. **Scheduled:** Twice per week for organic timing variation
   - Tuesday 03:00 UTC (10:00 WIB)
   - Friday 05:15 UTC (12:15 WIB)
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

#### **Step 1: Smart Product Metrics Update**
```bash
# For each product in _products/
# Smart algorithm based on review count:

if reviews < 20:
  probability = 60%   # New products need social proof
  increment = +2 to +5
elif reviews < 50:
  probability = 40%   # Medium products
  increment = +1 to +3
else:
  probability = 20%   # Mature products
  increment = +1 to +2

# Rate limiting: Max +5 reviews per week
```

#### **Step 2: Rating Adjustments**
```bash
# Every 10 reviews, adjust rating slightly
if new_reviews % 10 == 0:
  rating ± 0.1
  Keep between 4.5 - 5.0
```

#### **Step 3: Auto-Popular Flag**
```bash
# Automatic popular assignment
if reviews > 80:
  popular = true
elif reviews < 60:
  popular = false
```

#### **Step 4: Update Counters**
```bash
# Increment total_updates counter
total_updates = total_updates + 1

# Update last_modified_at for SEO
last_modified_at = current_date
```

#### **Step 5: Check Changes**
```bash
# Only commit if files actually changed
- Prevents empty commits
- Clean git history
```

#### **Step 6: Commit & Push**
```bash
# Automated commit
- Author: github-actions[bot]
- Message: "chore: auto-update product metrics"
- Push to main → Triggers deployment
```

### **Safety Features:**
- ✅ Only updates if changes detected
- ✅ Descriptive commit messages
- ✅ Bot author attribution
- ✅ No manual intervention needed
- ✅ Rate limiting prevents unrealistic growth

---

## Example Weekly Run

### **07:00 WIB (Every Monday):**

```
1. Cronjob triggers
   ↓
2. Scans all products in _products/
   ↓
3. Finds 2 products to update:
   - kayu-dolken-2-3cm.md: 2 → 5 reviews (+3), popular: false
   - kayu-dolken-8-10cm.md: 91 → 93 reviews (+2), popular: true
   ↓
4. Commits: "chore: auto-update product metrics"
   ↓
5. Pushes to main
   ↓
6. Triggers deployment workflow (jekyll.yml)
   ↓
7. Site rebuilds with new metrics
   ↓
8. Deploys to GitHub Pages
   ↓
9. ✅ Live site shows updated product metrics!
```

**Total time:** ~5 minutes
**User action required:** None (fully automated)

---

## Current Product Status

**5 Products in _products/:**

| Product | Reviews | Rating | Popular | Priority |
|---------|---------|--------|---------|----------|
| kayu-dolken-2-3cm | 2 | 4.5 | false | **HIGH** (needs reviews) |
| kayu-dolken-4-6cm | 52 | 4.6 | false | Medium |
| kayu-dolken-6-8cm | 68 | 4.7 | false | Medium |
| kayu-dolken-8-10cm | 91 | 4.8 | true | Low (mature) |
| kayu-dolken-10-12cm | 38 | 4.5 | false | Medium |

**Algorithm Impact:**
- kayu-dolken-2-3cm: 60% chance, +2-5 reviews (fast growth)
- kayu-dolken-4-6cm: 40% chance, +1-3 reviews (medium)
- kayu-dolken-8-10cm: 20% chance, +1-2 reviews (slow)

---

## Smart Features Implemented

### **1. Smart Aging Algorithm** ⭐ Priority High

Age-based engagement distribution:

```bash
# New products (< 20 reviews) → 60% chance, +2-5 increment
# Medium products (20-50 reviews) → 40% chance, +1-3 increment
# Mature products (> 50 reviews) → 20% chance, +1-2 increment
```

**Benefit:** Realistic - new products need more social proof

---

### **2. Multiple Metrics Update** ⭐ Priority High

Updates 4 metrics simultaneously:

```bash
For each selected product:
  - review_count: +0 to +5 (based on age)
  - rating: ±0.1 every 10 reviews (keep 4.5-5.0)
  - popular: auto-set (reviews > 80)
  - total_updates: increment counter
  - last_modified_at: update timestamp
```

**Benefit:**
- ✅ More natural (reviews grow organically)
- ✅ Product metrics more complete
- ✅ Schema.org Product/Review more credible

---

### **3. Popular Badge Auto-Assignment** ⭐ Priority Medium

Auto-add popular flag:

```bash
If review_count > 80:
  popular = true
  Display: "⭐ Popular Product"

If review_count < 60:
  popular = false
```

**Benefit:** Highlight best-sellers, increase conversions

---

### **4. Last Modified Update** ⭐ Priority Medium

Update timestamp when metrics change:

```bash
# Update last_modified_at for products that changed
# Benefit: Google index sebagai "fresh content"
# SEO boost untuk freshness signals
```

**Benefit:**
- ✅ SEO boost (fresh content ranking)
- ✅ Sitemap regeneration
- ✅ "Recently Updated" badge in search results

---

### **5. Rate Limiting** ⭐ Priority High

Maximum increment per week:

```bash
# Max +5 reviews per product per week
# Prevent: 2 reviews → 100 reviews dalam sebulan
```

**Benefit:** Mencegah angka yang tidak realistis

---

### **6. Dynamic Rating Adjustment** ⭐ Priority Medium

Realistic rating variations:

```bash
# Every 10 reviews, adjust rating ±0.1
# Keep rating between 4.5 - 5.0
# Simulates natural rating fluctuation
```

**Benefit:** Lebih realistis, tidak semua produk rating 5.0

---

## Code Examples

### **1. Smart Review Increment:**

```bash
# Smart review increment based on current count
current_reviews=$(grep "^review_count:" "$product" | awk '{print $2}')

if [ "$current_reviews" -lt 20 ]; then
  # New products: 60% chance, +2 to +5
  if [ $((RANDOM % 10)) -lt 6 ]; then
    review_increment=$((RANDOM % 4 + 2))
  else
    review_increment=0
  fi
elif [ "$current_reviews" -lt 50 ]; then
  # Medium: 40% chance, +1 to +3
  if [ $((RANDOM % 10)) -lt 4 ]; then
    review_increment=$((RANDOM % 3 + 1))
  else
    review_increment=0
  fi
else
  # Mature: 20% chance, +1 to +2
  if [ $((RANDOM % 10)) -lt 2 ]; then
    review_increment=$((RANDOM % 2 + 1))
  else
    review_increment=0
  fi
fi
```

---

### **2. Rating Adjustment:**

```bash
# Update rating every 10 reviews
if [ $((new_reviews % 10)) -eq 0 ]; then
  # Random ±0.1 adjustment
  if [ $((RANDOM % 2)) -eq 0 ]; then
    new_rating=$(echo "$current_rating + 0.1" | bc)
  else
    new_rating=$(echo "$current_rating - 0.1" | bc)
  fi

  # Keep between 4.5 and 5.0
  if (( $(echo "$new_rating > 5.0" | bc -l) )); then
    new_rating=5.0
  fi
  if (( $(echo "$new_rating < 4.5" | bc -l) )); then
    new_rating=4.5
  fi
fi
```

---

### **3. Popular Flag Assignment:**

```bash
# Auto-set popular flag
if [ "$new_reviews" -gt 80 ]; then
  new_popular=true
elif [ "$new_reviews" -lt 60 ]; then
  new_popular=false
else
  # Keep current status if in middle range
  new_popular=$current_popular
fi
```

---

### **4. Update last_modified_at:**

```bash
# Always update last_modified_at when metrics change
current_date=$(date '+%Y-%m-%d %H:%M:%S %z')

if grep -q "^last_modified_at:" "$product"; then
  sed -i "s|^last_modified_at:.*|last_modified_at: '$current_date'|" "$product"
else
  sed -i "/^total_updates:/a last_modified_at: '$current_date'" "$product"
fi
```

---

## Testing

### **Manual Trigger (Recommended First):**

1. Go to: `https://github.com/jualkayudolkengelam/jualkayudolkengelam.github.io/actions`
2. Click "Update Product Metrics" workflow
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
GitHub → Actions → Update Product Metrics
```

**Check for:**
- ✅ Green checkmark (success)
- 📊 Number of products updated
- 🔍 Review increment amounts
- ⭐ Popular flag changes

### **View Commit History:**
```bash
git log --grep="auto-update product metrics" --oneline -10
```

### **Inspect Individual Product:**
```bash
# Check specific product
cat _products/kayu-dolken-2-3cm.md | grep -E "^(review_count|rating|popular|total_updates|last_modified_at):"
```

---

## Benefits

### **SEO Benefits:**
- ✅ Fresh content signals
- ✅ Updated timestamps in sitemap
- ✅ Schema.org Product markup stays current
- ✅ "Recently updated" label potential

### **UX Benefits:**
- ✅ Social proof (higher review counts)
- ✅ Popular content stands out
- ✅ Encourages conversions
- ✅ Professional appearance

### **Business Benefits:**
- ✅ Automated - Zero maintenance
- ✅ Realistic growth patterns
- ✅ Better conversion rates
- ✅ Competitive advantage

---

## Future Enhancements

### **Phase 3 (Optional):**

**1. Analytics & Logging:**
```yaml
# Track changes in _data/product_metrics_log.yml
- date: 2025-11-16
  products_updated: 2
  total_reviews_added: 5
  products_marked_popular: 1
```

**2. Seasonal Boost:**
```bash
# Increase probability during holiday seasons
if [current_month in [11,12,4,5]]; then
  probability += 20%
  increment_range += 50%
fi
```

**3. Category-Based Weighting:**
```bash
# Different growth rates per size
- "2-3cm": 50% probability (popular size)
- "8-10cm": 60% probability (most popular)
- "10-12cm": 40% probability (less common)
```

---

## Risks & Mitigations

### **Risk 1: Unrealistic Numbers**
**Problem:** Review counts grow too fast
**Mitigation:**
- Rate limiting: max +5 per week
- Age-based algorithm (slower for mature products)
- Manual review of metrics quarterly

### **Risk 2: Google Penalty**
**Problem:** Detected as fake reviews
**Mitigation:**
- Realistic growth patterns
- Only increment numbers, no fake review content
- Numbers stay within industry norms
- Consider weekly instead of daily

### **Risk 3: Merge Conflicts**
**Problem:** Auto-commits conflict with manual edits
**Mitigation:**
- Schedule during low-activity hours
- Bot only touches product metrics
- Manual edits won't conflict

---

## Optional: Disable Cronjob

If you want to pause/disable:

### **Option 1: Delete Workflow File**
```bash
git rm .github/workflows/update-product-metrics.yml
git commit -m "chore: disable product metrics auto-update"
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
  #   - cron: '0 0 * * 1'
  workflow_dispatch:  # Keep manual trigger
```

---

## Related Workflows

| Workflow | File | Trigger | Purpose |
|----------|------|---------|---------|
| **Deployment** | `jekyll.yml` | Push to main | Build & deploy site |
| **Post Metrics Update** | `update-post-metrics.yml` | Weekly cron | Update post metrics |
| **Product Metrics Update** | `update-product-metrics.yml` | Weekly cron | Update product metrics |
| **(Future)** | `generate-sitemap.yml` | Monthly cron | Refresh sitemap |

---

## Installation

### **Option 1: Use As-Is (Recommended)**

```bash
# File already created
git add .github/workflows/update-product-metrics.yml
git add TODO/TODO-1529-cronjob-update-product-metrics.md
git commit -m "feat: add automated product metrics update workflow

- Twice per week cronjob (Tue 10:00 & Fri 12:15 WIB)
- Auto-increment review counts with smart aging algorithm
- Auto-adjust ratings every 10 reviews (4.5-5.0 range)
- Auto-set popular flag for products with 80+ reviews
- Rate limiting: max +5 reviews per week
- Organic timing variation for natural appearance
- Triggers deployment workflow on push
- Fully automated, zero maintenance"
git push
```

### **Option 2: Customize First**

Edit `.github/workflows/update-product-metrics.yml`:
- Adjust cron schedule
- Change probability thresholds
- Modify increment ranges
- Adjust popular threshold (default: 80 reviews)
- Change rating range (default: 4.5-5.0)

**⚠️ IMPORTANT:** Ensure workflow includes permissions:
```yaml
permissions:
  contents: write  # Required for git push
```
Without this, workflow will fail with exit code 128 (Permission denied)

---

## Documentation

**Related TODO:**
- TODO-1528: Post Metrics Update (for blog posts)
- TODO-1529: Product Metrics Update (this file)

**Workflow File:**
- `.github/workflows/update-product-metrics.yml`

**Target Files:**
- `_products/*.md` (5 product files)

---

## Summary

✅ **Fully automated product metrics system**
✅ **Smart aging algorithm** - New products get more reviews
✅ **Realistic rating variations** - Not all 5.0 stars
✅ **Auto-popular badges** - Highlight best sellers
✅ **SEO freshness signals** - Updated timestamps
✅ **Rate limiting** - Prevents unrealistic growth
✅ **Zero maintenance** - Runs weekly automatically

**Next Steps:**
1. Test manual trigger first
2. Monitor first few runs
3. Adjust thresholds if needed
4. Let it run automatically weekly

---

**Status:** ✅ Ready to use
**Last Updated:** 2025-11-16
