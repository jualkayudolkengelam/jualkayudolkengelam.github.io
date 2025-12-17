# TODO-1520: Homepage Schema Duplication Fix

**Date:** 2025-11-16
**Status:** ✅ Completed
**Type:** Critical Bug Fix / Schema.org Fix

---

## Task Summary

Fix **critical schema.org duplication** pada homepage (`/`) dimana products muncul DUA KALI (10 products total) di Google Rich Results Test - sama seperti masalah di halaman `/product/`.

---

## Problem Identified

### Critical Issue:
- Homepage menampilkan **DUPLIKASI schema.org**
- Products muncul **10x** (seharusnya hanya 5)
- 5 products dari schema di `index.html`
- 5 products dari schema di `_includes/head.html`
- Confusing untuk search engines dan potential SEO penalty

### Root Cause:

**Duplikasi terjadi karena dua source schema:**

1. **Schema di `index.html`** (lines 9-105)
   ```json
   {
     "@context": "https://schema.org",
     "@graph": [
       { "@type": "BreadcrumbList", ... },
       {
         "@type": "ItemList",
         "itemListElement": [
           { "@type": "Product", ... },  // 5 products
           ...
         ]
       }
     ]
   }
   ```

2. **Schema di `_includes/head.html`** (line 35)
   ```liquid
   {% if page.url == '/' or page.layout == 'product' %}
     <!-- LocalBusiness + OfferCatalog with 5 products -->
   {% endif %}
   ```

**Kondisi `page.url == '/'` di head.html** menyebabkan homepage dapat:
- Schema @graph dari index.html (5 products)
- Schema LocalBusiness dari head.html (5 products)
- **Total = 10 products** ❌

### Impact:
- 🔴 **Critical:** Duplikasi schema confuses search engines
- 🔴 Products muncul 2x di Rich Results
- 🔴 Same issue as product listing page
- 🟠 Potential ranking penalty

---

## Solution Implemented

### Fix 1: Remove Homepage from head.html Conditional

**File:** `_includes/head.html` (line 35)

**Before:**
```liquid
{% if page.url == '/' or page.layout == 'product' %}
  <!-- LocalBusiness + OfferCatalog -->
{% endif %}
```

**After:**
```liquid
{% if page.layout == 'product' %}
  <!-- LocalBusiness + OfferCatalog -->
{% endif %}
```

**Changes:**
- ❌ Removed `page.url == '/'` - homepage has its own schema
- ✅ Keep `page.layout == 'product'` - individual product pages only

**Result:**
- `/` (homepage) → NO LocalBusiness from head.html ✅ (uses its own @graph schema)
- `/product/kayu-dolken-*/` (individual) → Has LocalBusiness ✅

---

### Fix 2: Dynamic Rating on Homepage

**File:** `index.html` (lines 92-98)

**Before (Hardcoded):**
```liquid
"aggregateRating": {
  "@type": "AggregateRating",
  "ratingValue": "{% if product.popular %}4.8{% else %}4.5{% endif %}",
  "reviewCount": "{% if product.popular %}127{% else %}45{% endif %}",
```

**After (Dynamic):**
```liquid
"aggregateRating": {
  "@type": "AggregateRating",
  "ratingValue": "{{ product.rating | default: 4.5 }}",
  "reviewCount": "{{ product.review_count | default: 45 }}",
```

**Benefits:**
- ✅ Consistent with product.html and individual product pages
- ✅ Uses product front matter data
- ✅ Falls back to default if not specified
- ✅ No more hardcoded conditionals

---

## Technical Details

### Homepage Schema Structure After Fix

**Only ONE schema (from index.html):**
```json
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "BreadcrumbList",
      "itemListElement": [
        {
          "@type": "ListItem",
          "position": 1,
          "name": "Beranda",
          "item": "https://jualkayudolkengelam.net/"
        }
      ]
    },
    {
      "@type": "ItemList",
      "name": "Daftar Harga Kayu Dolken Gelam",
      "numberOfItems": 5,
      "itemListElement": [
        {
          "@type": "Product",
          "name": "Jual Kayu Dolken Gelam Diameter 2-3 cm",
          "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "4.5",
            "reviewCount": "45"
          },
          ...
        },
        // ... 4 more products
      ]
    }
  ]
}
```

### Why @graph Schema Better for Homepage?

**@graph Advantages:**
- ✅ Allows multiple schema types in one block
- ✅ BreadcrumbList for navigation
- ✅ ItemList for product listing
- ✅ Semantically correct for multi-purpose page
- ✅ Google understands @graph structure well
- ✅ No need for separate LocalBusiness (homepage is product listing)

**Homepage is primarily a product listing page**, jadi ItemList lebih cocok daripada LocalBusiness + OfferCatalog!

---

## Schema Coverage After All Fixes

| Page | URL | Schema Type | Source | Duplication? |
|------|-----|-------------|--------|--------------|
| **Homepage** | `/` | **@graph: BreadcrumbList + ItemList** ✅ | **index.html** | ✅ **FIXED!** |
| Product Listing | `/product/` | ItemList + Product (x5) | product.html | ✅ Fixed (TODO-1519) |
| Individual Product | `/product/*` | LocalBusiness + OfferCatalog | head.html | ✅ No duplication |
| Blog Listing | `/blog/` | CollectionPage + ItemList | head.html | ✅ No duplication |
| Blog Post | `/blog/*/*` | BlogPosting | head.html | ✅ No duplication |
| About | `/tentang/` | AboutPage + Organization | head.html | ✅ No duplication |
| Contact | `/kontak/` | ContactPage + LocalBusiness | head.html | ✅ No duplication |

**All pages now have CLEAN, single-source schema.org!** 🎉

---

## Verification

**Build Status:** ✅ Success
```bash
./rebuild.sh
# Generated 134 files (29M)
```

**Product Count Verification:**
```bash
# Count Product schemas on homepage
grep -c '"@type": "Product"' _site/index.html
# Output: 5 ✅ (NOT 10 anymore!)

# Verify NO LocalBusiness on homepage
grep -c '"@type": "LocalBusiness"' _site/index.html
# Output: 0 ✅ (removed successfully)

# Verify LocalBusiness still exists on individual product pages
grep -c '"@type": "LocalBusiness"' _site/product/kayu-dolken-2-3cm/index.html
# Output: 1 ✅ (still present)
```

**Schema Types on Homepage:**
```bash
grep '@type' _site/index.html | head -10
```
Output shows:
- BreadcrumbList ✅
- ListItem ✅
- ItemList ✅
- Product (x5) ✅
- Brand, Offer, Organization, etc. ✅
- NO LocalBusiness ✅
- NO OfferCatalog ✅

**Generated HTML Path:**
`_site/index.html`

**Live URL:**
`https://jualkayudolkengelam.net/`

---

## Before vs After Comparison

### Before (WRONG - 10 Products):

**Schema 1 (from head.html):**
```json
{
  "@type": "LocalBusiness",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "itemListElement": [
      { "@type": "Offer", "itemOffered": { "@type": "Product", ... } },  // 5 products
      ...
    ]
  }
}
```

**Schema 2 (from index.html):**
```json
{
  "@graph": [
    { "@type": "BreadcrumbList", ... },
    {
      "@type": "ItemList",
      "itemListElement": [
        { "@type": "Product", ... },  // 5 products
        ...
      ]
    }
  ]
}
```

❌ **Total: 10 products** (duplikasi!)

---

### After (CORRECT - 5 Products):

**Only ONE schema (from index.html):**
```json
{
  "@graph": [
    { "@type": "BreadcrumbList", ... },
    {
      "@type": "ItemList",
      "itemListElement": [
        { "@type": "Product", ... },  // 5 products only
        ...
      ]
    }
  ]
}
```

✅ **Total: 5 products** (no duplication!)

---

## Benefits

### SEO:
- ✅ No more schema duplication on homepage
- ✅ Clean, single source of truth
- ✅ BreadcrumbList helps with navigation
- ✅ ItemList appropriate for product listing page
- ✅ Better Google Rich Results display
- ✅ Prevents potential ranking penalty

### User Experience:
- ✅ Accurate product count in search results
- ✅ No confusing duplicate displays
- ✅ Consistent rating display across site

### Technical:
- ✅ Each page owns its schema (separation of concerns)
- ✅ Homepage has more appropriate @graph schema
- ✅ Individual product pages keep LocalBusiness schema
- ✅ Dynamic rating system consistent across all pages

---

## Complete Schema.org Architecture

### Final Conditional Logic in head.html:

```liquid
<!-- LocalBusiness + OfferCatalog -->
{% if page.layout == 'product' %}
  <!-- Individual product pages ONLY -->
{% endif %}

<!-- CollectionPage + ItemList -->
{% if page.url == '/blog' or page.url == '/blog/' %}
  <!-- Blog listing page -->
{% endif %}

<!-- AboutPage + Organization -->
{% if page.url == '/tentang' or page.url == '/tentang/' %}
  <!-- About page -->
{% endif %}

<!-- ContactPage + LocalBusiness -->
{% if page.url == '/kontak' or page.url == '/kontak/' %}
  <!-- Contact page -->
{% endif %}

<!-- BlogPosting -->
{% if page.layout == 'post' %}
  <!-- Individual blog posts -->
{% endif %}
```

**NOT in head.html:**
- Homepage `/` → Has schema in `index.html`
- Product listing `/product/` → Has schema in `product.html`

---

## Files Modified

1. `_includes/head.html` (line 35)
   - Removed `page.url == '/'` from conditional
   - Updated comment to reflect changes

2. `index.html` (lines 92-98)
   - Changed hardcoded rating to dynamic `product.rating`
   - Changed hardcoded reviewCount to dynamic `product.review_count`

---

## Related TODOs

- TODO-1519: Product Page Duplication Fix (same issue, same solution pattern)
- TODO-1518: Kontak Page Schema Fix
- TODO-1517: Tentang Page Schema Fix

---

## Testing Checklist

- [x] Rebuild successful
- [x] Only 5 Product schemas on homepage (not 10)
- [x] No LocalBusiness schema on homepage
- [x] BreadcrumbList present
- [x] ItemList present
- [x] @graph structure correct
- [x] Individual product pages still have LocalBusiness
- [x] Dynamic rating working
- [x] Product listing page still clean (no duplication)

---

## Key Learnings

### Pattern Discovered:
Homepage dan Product listing pages **shouldn't use LocalBusiness + OfferCatalog** from head.html because:
1. They already have their own specific schemas (ItemList)
2. Using both creates duplication
3. ItemList is more semantic for listing pages

### Solution Pattern:
- **head.html** = Generic schemas for simple pages (contact, about, blog)
- **Page-specific files** = Custom schemas for complex pages (homepage, product listing)
- **Layout-based** = Schemas for templated pages (individual products, blog posts)

---

**Status:** ✅ Completed
**Next:** Test semua halaman dengan Google Rich Results Test untuk confirm ALL duplications sudah hilang
