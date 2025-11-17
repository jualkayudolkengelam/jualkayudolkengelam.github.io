# Related Content & Products Templates

Sistem modular untuk menampilkan related content dan products dengan berbagai strategi.

## File Structure

```
_includes/
├── block--related-content--by-node.html     ✅ IMPLEMENTED
├── related-content-by-new-post.html    🔲 TODO
├── related-content-by-category.html    🔲 TODO
├── block--related-product--by-node.html    ✅ IMPLEMENTED
├── related-products-by-new-post.html   🔲 TODO
└── related-products-by-category.html   🔲 TODO
```

---

## 1. Related Content Templates

### ✅ `block--related-content--by-node.html`

**Strategy:** Node proximity (sequential)

**Logic:**
- Artikel di node 20 → tampilkan artikel 17, 18, 19
- Circular wrapping untuk artikel di awal array
- Fair distribution: semua artikel dapat exposure

**Usage:**
```liquid
{% include block--related-content--by-node.html %}
{% include block--related-content--by-node.html limit=6 %}
```

**Best For:**
- Artikel tutorial/informasi yang tidak bergantung waktu
- Distribusi traffic yang merata

---

### 🔲 `related-content-by-new-post.html` (TODO)

**Strategy:** Chronological (latest posts)

**Planned Logic:**
- Tampilkan 3 artikel terbaru (exclude artikel saat ini)
- Sorted by date descending
- Fresh content exposure

**Planned Usage:**
```liquid
{% include related-content-by-new-post.html %}
{% include related-content-by-new-post.html limit=5 %}
```

**Best For:**
- Blog dengan update frequent
- News atau artikel dengan time-sensitive content
- Homepage atau landing page

---

### 🔲 `related-content-by-category.html` (TODO)

**Strategy:** Smart matching (category + tags)

**Planned Logic:**
- Match articles dengan kategori yang sama
- Secondary match: tags yang sama
- Relevance scoring system
- Fallback to recent posts if no match

**Planned Usage:**
```liquid
{% include related-content-by-category.html %}
{% include related-content-by-category.html limit=4 %}
```

**Best For:**
- Content-heavy websites dengan banyak kategori
- User journey optimization
- Artikel dengan topik spesifik

---

## 2. Related Products Templates

### ✅ `block--related-product--by-node.html`

**Strategy:** Rotation based on article node position

**Logic:**
- Menggunakan modulo untuk menentukan starting point
- Artikel node N → produk mulai dari (N % total_products)
- Circular rotation: semua produk dapat exposure merata

**Example (5 products: P0-P4):**
- Node 0 → P0, P1, P2
- Node 1 → P1, P2, P3
- Node 2 → P2, P3, P4
- Node 3 → P3, P4, P0 (wrap)
- Node 5 → P0, P1, P2 (repeat cycle)

**Usage:**
```liquid
{% include block--related-product--by-node.html %}
```

**Best For:**
- Fair product exposure
- Predictable product display
- Artikel tutorial dengan banyak produk

---

### ✅ `block--related-product--by-last-modified.html` ⭐ **HYBRID**

**Strategy:** Show most recently updated products (Hybrid freshness)

**Logic:**
- Sort products by `last_modified_at` descending
- Display 3 most recently updated products
- Changes automatically when products are updated via cron
- **Hybrid Update System:**
  - Every update: review_count++, rating adjust
  - Every 5 updates: Add real review to content

**How It Works:**
```
Week 1: Update Produk A → last_mod: 15 Nov
Week 2: Update Produk B → last_mod: 22 Nov
Week 3: Update Produk C → last_mod: 29 Nov

Any Article Shows:
- Produk C (29 Nov) ← newest
- Produk B (22 Nov)
- Produk A (15 Nov)
→ Content changes every week!
```

**Usage:**
```liquid
{% include block--related-product--by-last-modified.html %}
```

**Best For:**
- ✅ SEO freshness signal
- ✅ Dynamic content without editing articles
- ✅ Automated with GitHub Actions
- ✅ Real value (real reviews every 5 updates)

**Automation:**
See: `scripts/update-product-hybrid.rb` and `scripts/README-hybrid-strategy.md`

---

### 🔲 `related-products-by-new-post.html` (TODO)

**Strategy:** Show newest/featured products

**Planned Logic:**
- Tampilkan 3 produk terbaru yang ditambahkan
- Sorted by product creation date
- Highlight new products to all visitors

**Planned Usage:**
```liquid
{% include related-products-by-new-post.html %}
```

**Best For:**
- Product launch campaigns
- Seasonal products
- Limited time offers

---

### 🔲 `related-products-by-category.html` (TODO)

**Strategy:** Match products to article context

**Planned Logic:**
- Analyze article content/tags
- Match relevant product sizes/categories
- Example: Artikel tentang "pagar" → tampilkan produk 4-6cm (pagar size)
- Fallback to popular products if no match

**Planned Usage:**
```liquid
{% include related-products-by-category.html %}
```

**Best For:**
- Contextual product recommendations
- Higher conversion rate
- Personalized user experience

---

## Current Implementation

### Layout: `post.html` & `post-with-products.html`

```liquid
<!-- Related Articles (existing) -->
{% include block--related-content--latest.html %}

<!-- Related Products (HYBRID: Last Modified Strategy) -->
{% include block--related-product--by-last-modified.html %}
```

**Active Strategy:** Hybrid Last-Modified (SEO Freshness)

---

## How to Switch Strategies

### Example 1: Use new-post strategy instead
```liquid
<!-- Change from node-based to new-post -->
{% include related-content-by-new-post.html %}
{% include related-products-by-new-post.html %}
```

### Example 2: Mix strategies
```liquid
<!-- Articles by node proximity -->
{% include block--related-content--by-node.html limit=3 %}

<!-- Products by category match -->
{% include related-products-by-category.html %}
```

### Example 3: Multiple sections
```liquid
<!-- Latest articles -->
{% include related-content-by-new-post.html limit=3 title="Artikel Terbaru" %}

<!-- Related by category -->
{% include related-content-by-category.html limit=3 title="Artikel Terkait" %}

<!-- Products rotation -->
{% include block--related-product--by-node.html %}
```

---

## Performance Notes

- All templates limit to 3 items by default
- Circular logic prevents out-of-bounds errors
- Sorted arrays ensure consistent ordering
- Modulo arithmetic for fair distribution

---

## TODO List

- [ ] Create `related-content-by-new-post.html`
- [ ] Create `related-content-by-category.html`
- [ ] Create `related-products-by-new-post.html`
- [ ] Create `related-products-by-category.html`
- [x] **Create Hybrid Update System** ⭐
- [ ] Setup GitHub Actions for automation
- [ ] Add A/B testing capability
- [ ] Add analytics tracking per strategy
- [ ] Document conversion metrics per strategy

---

## Hybrid System

✅ **Active:** `block--related-product--by-last-modified.html`
✅ **Script:** `scripts/update-product-hybrid.rb`
✅ **Documentation:** `scripts/README-hybrid-strategy.md`

**How It Works:**
1. Script runs weekly (via cron or GitHub Actions)
2. Updates 1 product per week (rotating)
3. Every update: review_count++, rating adjust
4. Every 5 updates: Add real review to content
5. Template shows 3 most recently updated products
6. **Result:** Dynamic content without editing articles!

---

**Last Updated:** 2025-11-15
**Status:** 3/6 templates implemented (+ Hybrid System ⭐)
