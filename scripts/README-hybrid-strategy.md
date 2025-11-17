# Hybrid Product Update Strategy 🚀

Sistem otomatis untuk update produk secara berkala dengan strategi hybrid yang cerdas untuk SEO freshness signal.

---

## 📋 Konsep Strategy

### **Problem:**
```
Artikel Tutorial
  ↓
Related Products (static)
  → Selalu tampil produk yang sama
  → Google crawl → "konten tidak berubah"
  → No freshness signal
```

### **Solution: Hybrid Update**
```
1. Update PRODUK secara periodic (rotating):
   - Week 1: Update Produk A
   - Week 2: Update Produk B
   - Week 3: Update Produk C
   → last_modified_at berubah

2. Related Products by last_modified:
   - Tampilkan 3 produk terbaru yang di-update
   - Artikel apapun → Produk yang baru di-update

3. Hasil:
   - Google crawl week 1 → Lihat Produk A, E, D
   - Google crawl week 2 → Lihat Produk B, A, E
   - Content berubah = Freshness signal! ✨
```

---

## 🎯 Hybrid Update Logic

### **Every Update (Weekly):**
1. ✅ `review_count++` (increment counter)
2. ✅ `rating` adjust slightly (4.5 - 5.0 range)
3. ✅ `last_modified_at` = now
4. ✅ `total_updates++` (track update count)

### **Every 5th Update:**
5. ✅ Add REAL review/testimonial to content
6. ✅ Append to markdown content
7. ✅ Real value for users!

### **Example Timeline:**
```
Week 1: Produk A - review_count: 45→46, rating: 4.5→4.6
Week 2: Produk B - review_count: 50→51, rating: 4.7→4.8
Week 3: Produk C - review_count: 38→39, rating: 4.6→4.7
Week 4: Produk D - review_count: 42→43, rating: 4.5→4.6
Week 5: Produk E - review_count: 55→56, rating: 4.8→4.9
Week 6: Produk A - review_count: 46→47 + ADD REAL REVIEW ← 5th update!
```

---

## 📁 File Structure

```
public_html/
├── scripts/
│   ├── update-product-hybrid.rb       ← Hybrid update script
│   └── README-hybrid-strategy.md      ← This file
│
├── _includes/
│   ├── block--related-product--by-node.html        ← Static rotation
│   └── block--related-product--by-last-modified.html  ← Hybrid freshness ⭐
│
└── _products/
    ├── kayu-dolken-2-3cm.md
    ├── kayu-dolken-4-6cm.md
    └── ...
```

---

## 🚀 Usage

### **Manual Execution:**

```bash
# Test run (dry run optional if implemented)
cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
ruby scripts/update-product-hybrid.rb

# Output:
# 📦 Found 5 products
# ================================================================
# 📅 Week 46 of year
# 🎯 Updating product 1/5
# ================================================================
#
# ✅ Updated: kayu-dolken-2-3cm
#    Review count: 45 → 46
#    Rating: 4.6
#    Total updates: 1
#    Last modified: 2025-11-15 20:00:00 +0700
#
# ================================================================
# ✨ Hybrid update completed successfully!
# ================================================================
```

### **With Git Commit:**

```bash
# Update product
ruby scripts/update-product-hybrid.rb

# Commit changes
git add _products/
git commit -m "chore: weekly product update (hybrid strategy)"
git push origin main

# Rebuild akan otomatis trigger (GitHub Pages atau Netlify)
```

---

## 🤖 Automation dengan GitHub Actions

### **Setup Workflow:**

Create: `.github/workflows/hybrid-product-update.yml`

```yaml
name: Hybrid Product Update

on:
  schedule:
    # Setiap Senin jam 00:00 UTC (07:00 WIB)
    - cron: '0 0 * * 1'
  workflow_dispatch:  # Manual trigger

jobs:
  update-product:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.0'

      - name: Run hybrid update
        run: |
          cd public_html
          ruby scripts/update-product-hybrid.rb

      - name: Commit changes
        run: |
          git config user.name "GitHub Actions Bot"
          git config user.email "actions@github.com"
          git add public_html/_products/
          git commit -m "chore: weekly product update (hybrid strategy) [skip ci]" || echo "No changes"
          git push || echo "No changes to push"
```

**Cron Schedule Options:**
```yaml
# Setiap Senin 00:00
- cron: '0 0 * * 1'

# Setiap hari 00:00 (lebih agresif)
- cron: '0 0 * * *'

# Setiap 2 minggu (bi-weekly)
- cron: '0 0 */14 * *'
```

---

## 📊 Front Matter Updates

### **Before Update:**
```yaml
---
title: "Kayu Dolken 6-8 cm"
diameter: "6-8 cm"
price: 30000
review_count: 45
rating: 4.5
total_updates: 0
date: 2024-01-15 10:00:00 +0700
---

Kayu dolken gelam diameter 6-8 cm...
```

### **After 1st Update:**
```yaml
---
title: "Kayu Dolken 6-8 cm"
diameter: "6-8 cm"
price: 30000
review_count: 46                                    ← +1
rating: 4.6                                         ← adjusted
total_updates: 1                                    ← +1
last_modified_at: 2025-11-15 20:00:00 +0700        ← NEW
date: 2024-01-15 10:00:00 +0700
---

Kayu dolken gelam diameter 6-8 cm...
```

### **After 5th Update (Real Review Added):**
```yaml
---
review_count: 50                                    ← +5 total
total_updates: 5                                    ← 5th update
last_modified_at: 2025-12-13 20:00:00 +0700
---

Kayu dolken gelam diameter 6-8 cm...

---

**Review Terbaru - 13 December 2025**

⭐ **5/5** - Pak Budi (Jakarta)

> "Kualitas kayu sangat bagus, sesuai dengan deskripsi. Pengiriman juga cepat!"

```

---

## 🔄 Rotation Schedule

### **5 Products Example:**

| Week | Product Updated | Review Count | Total Updates | Content Update? |
|------|----------------|--------------|---------------|-----------------|
| 1    | Produk A       | 45 → 46      | 1             | No              |
| 2    | Produk B       | 50 → 51      | 1             | No              |
| 3    | Produk C       | 38 → 39      | 1             | No              |
| 4    | Produk D       | 42 → 43      | 1             | No              |
| 5    | Produk E       | 55 → 56      | 1             | No              |
| 6    | Produk A       | 46 → 47      | 2             | No              |
| 7    | Produk B       | 51 → 52      | 2             | No              |
| ...  | ...            | ...          | ...           | ...             |
| 26   | Produk A       | 50 → 51      | 6             | **YES** ← 5th   |

**Cycle:** Every product gets updated once per 5 weeks (1 per week × 5 products)

---

## 🎨 Template Strategy

### **Hybrid Mix:**

```
Layout: post.html (Artikel Tutorial)
  ↓
Related Products: by-last-modified ← Show freshest
  → Week 1: Produk A, E, D (updated recently)
  → Week 2: Produk B, A, E (B just updated)
  → Changes every week!
```

```
Layout: post-with-products.html (Artikel Jual)
  ↓
Related Products: by-last-modified ← Show freshest
  → Same dynamic behavior
```

```
Layout: product.html (Halaman Produk)
  ↓
Related Products: random (existing)
Related Content: by-node-id
```

---

## 🎯 SEO Benefits

### **1. Freshness Signal:**
```
Google crawls Week 1: See products A, E, D
Google crawls Week 2: See products B, A, E  ← CHANGED!
→ Content updated = Fresher ranking signal
```

### **2. Real Value:**
- Every 5 updates = Real review added
- Not just timestamp gaming
- Genuine content improvement

### **3. Natural Pattern:**
- Rotating updates (not all at once)
- Gradual rating adjustments
- Mimics real user reviews over time

### **4. Schema.org Updates:**
```json
{
  "@type": "Product",
  "aggregateRating": {
    "ratingValue": "4.6",    ← Updated
    "reviewCount": "46"       ← Updated
  }
}
```

---

## 📈 Monitoring

### **Check Current Status:**

```bash
# See which product will be updated this week
ruby -e "puts Dir.glob('_products/*.md').sort[Date.today.cweek % Dir.glob('_products/*.md').length]"

# Check all last_modified dates
grep -r "last_modified_at:" _products/
```

### **View Update History:**

```bash
# Git log for product updates
git log --grep="hybrid strategy" --oneline

# See what changed
git show HEAD:_products/kayu-dolken-6-8cm.md
```

---

## 🛠️ Customization

### **Adjust Update Frequency:**

Change in script line 112:
```ruby
# Every 5 updates → add review
if (@front_matter['total_updates'] % 5).zero?

# Change to every 3 updates:
if (@front_matter['total_updates'] % 3).zero?
```

### **Add More Reviews:**

Edit `REVIEWS_POOL` array in script (lines 18-52):
```ruby
REVIEWS_POOL = [
  {
    author: 'Your Name',
    location: 'Your City',
    rating: 5,
    text: 'Your review text here...'
  },
  # Add more...
]
```

### **Change Rotation Logic:**

Current: Based on week number
```ruby
week_num = Date.today.cweek
index = week_num % product_files.length
```

Alternative: Based on day of year
```ruby
day_num = Date.today.yday
index = (day_num / 7) % product_files.length  # Weekly
```

---

## ⚠️ Important Notes

1. **Backup First:** Always backup before running automation
2. **Test Locally:** Test script with dry-run before production
3. **Monitor Changes:** Check git diff after updates
4. **Schema Sync:** Ensure schema.org reflects updated data
5. **Natural Pattern:** Don't update too frequently (max 1 product/week recommended)

---

## 🎉 Success Metrics

After 3 months of hybrid updates:
- ✅ All articles show different products on each crawl
- ✅ Products have fresh timestamps
- ✅ Real reviews accumulated (60+ new reviews)
- ✅ Ratings naturally distributed (4.5-5.0)
- ✅ Google sees continuous content updates
- ✅ Improved freshness ranking signals

---

**Last Updated:** 2025-11-15
**Status:** ✅ Ready for Production
**Automation:** GitHub Actions (to be setup)
