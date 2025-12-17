# TODO-1519: Product Listing Page Schema Duplication Fix

**Date:** 2025-11-16
**Status:** ✅ Completed
**Type:** Critical Bug Fix / Schema.org Fix

---

## Task Summary

Fix **critical schema.org duplication** pada halaman `/product/` dimana product listings muncul DUA KALI di Google Rich Results Test dengan error non-kritis pada listing kedua.

---

## Problem Identified

### Critical Issue:
- Halaman `/product/` menampilkan **DUPLIKASI schema.org**
- Product listings muncul 2x di "Item yang terdeteksi"
- Error non-kritis: "1 masalah non-kritis" pada product set kedua
- Confusing untuk search engines dan potential SEO penalty

### Root Cause Analysis:

**Duplikasi terjadi karena dua source schema:**

1. **Schema di `product.html`** (lines 10-108)
   - Type: `ItemList` dengan Product items
   - Lengkap dengan shipping details, return policy, etc.
   - Spesifik untuk product listing page

2. **Schema di `_includes/head.html`** (line 36)
   - Type: `LocalBusiness` + `OfferCatalog`
   - Conditional: `page.url contains '/product'`
   - Applies to semua URL yang contain "/product"

**Kondisi di head.html:**
```liquid
{% if page.url == '/' or page.url contains '/product' or page.layout == 'product' %}
  <!-- LocalBusiness + OfferCatalog -->
{% endif %}
```

Kondisi `page.url contains '/product'` akan match:
- ✅ `/product/` (listing page) ← **DUPLIKASI!**
- ✅ `/product/kayu-dolken-2-3cm/` (individual product)
- ✅ `/product/kayu-dolken-4-6cm/` (individual product)
- etc.

### Impact:
- 🔴 **Critical:** Duplikasi schema confuses search engines
- 🔴 Product listings muncul 2x di Rich Results
- 🟠 Error non-kritis pada beberapa product properties
- 🟠 Potential ranking penalty dari Google

---

## Solution Implemented

### Fix 1: Remove Duplication in head.html

**File:** `_includes/head.html` (line 36)

**Before:**
```liquid
{% if page.url == '/' or page.url contains '/product' or page.layout == 'product' %}
```

**After:**
```liquid
{% if page.url == '/' or page.layout == 'product' %}
```

**Changes:**
- ❌ Removed `page.url contains '/product'` - too broad
- ✅ Keep `page.url == '/'` - for homepage
- ✅ Keep `page.layout == 'product'` - for individual product pages ONLY

**Result:**
- `/product/` (listing) → NO LocalBusiness schema ✅ (uses its own ItemList)
- `/product/kayu-dolken-*/` (individual) → Has LocalBusiness schema ✅
- `/` (homepage) → Has LocalBusiness schema ✅

---

### Fix 2: Dynamic Rating on Product Listing

**File:** `product.html` (lines 82-88)

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
- ✅ Consistent with individual product pages
- ✅ Uses product front matter data
- ✅ Falls back to default if not specified
- ✅ No more hardcoded conditionals based on `product.popular`

---

## Technical Details

### Schema Structure on /product/ Page

**Only ONE schema now:**
```json
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "name": "Daftar Produk Kayu Dolken Gelam",
  "numberOfItems": 5,
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "item": {
        "@type": "Product",
        "name": "Jual Kayu Dolken Gelam Diameter 2-3 cm",
        "aggregateRating": {
          "@type": "AggregateRating",
          "ratingValue": "4.5",
          "reviewCount": "45"
        },
        "offers": { ... },
        ...
      }
    },
    ...
  ]
}
```

**Total @type instances:** 76
- 1 ItemList
- 5 ListItem (one per product)
- 5 Product (one per product)
- 5 Brand
- 5 Offer
- 5 Organization (seller)
- 5 OfferShippingDetails
- 5 MonetaryAmount
- 5 DefinedRegion
- 5 ShippingDeliveryTime
- 10 QuantitativeValue (2 per product: handling + transit time)
- 5 MerchantReturnPolicy
- 5 AggregateRating
- 10 PropertyValue (2 per product: diameter + panjang)

**= 76 total @type instances** ✅

---

## Schema Coverage After Fix

| Page | URL | Schema Type | Source |
|------|-----|-------------|--------|
| Homepage | `/` | LocalBusiness + OfferCatalog | head.html |
| **Product Listing** | `/product/` | **ItemList + Product (x5)** ✅ | **product.html** |
| Individual Product | `/product/*` | LocalBusiness + OfferCatalog | head.html |
| Blog Listing | `/blog/` | CollectionPage + ItemList | head.html |
| Blog Post | `/blog/*/*` | BlogPosting | head.html |
| About | `/tentang/` | AboutPage + Organization | head.html |
| Contact | `/kontak/` | ContactPage + LocalBusiness | head.html |

**Key Principle:** Setiap halaman hanya punya SATU primary schema, no duplication!

---

## Verification

**Build Status:** ✅ Success
```bash
./rebuild.sh
# Generated 133 files (29M)
```

**Schema Count Verification:**
```bash
# Count ItemList schemas
grep '"@type": "ItemList"' _site/product/index.html | wc -l
# Output: 1 ✅ (only one ItemList)

# Count Product schemas
grep '"@type": "Product"' _site/product/index.html | wc -l
# Output: 5 ✅ (5 products)

# Total @type instances
grep -c '@type' _site/product/index.html
# Output: 76 ✅ (correct count)
```

**No More Duplication:**
```bash
grep -A 5 '@type' _site/product/index.html | head -30
```
Shows only ItemList → ListItem → Product hierarchy, no duplicate LocalBusiness!

**Generated HTML Path:**
`_site/product/index.html`

**Live URL:**
`https://jualkayudolkengelam.net/product/`

---

## Before vs After

### Before (WRONG - Duplication):

**Schema 1 (from head.html):**
```json
{
  "@type": "LocalBusiness",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "itemListElement": [
      { "@type": "Offer", "itemOffered": { "@type": "Product", ... } },
      ...
    ]
  }
}
```

**Schema 2 (from product.html):**
```json
{
  "@type": "ItemList",
  "itemListElement": [
    { "@type": "ListItem", "item": { "@type": "Product", ... } },
    ...
  ]
}
```

❌ **Result:** Products muncul 2x, duplikasi schema!

---

### After (CORRECT - No Duplication):

**Only ONE schema (from product.html):**
```json
{
  "@type": "ItemList",
  "itemListElement": [
    { "@type": "ListItem", "item": { "@type": "Product", ... } },
    ...
  ]
}
```

✅ **Result:** Products hanya muncul 1x, clean schema!

---

## Why ItemList Better Than OfferCatalog for Listing Page?

### ItemList (Current - BETTER):
- ✅ Semantically correct for "list of items" page
- ✅ Supports ListItem with position (numbered list)
- ✅ Google recognizes as product listing
- ✅ Allows detailed product properties per item
- ✅ Can include shipping, return policy per product

### OfferCatalog (Previous):
- ⚠️ Better for "catalog of offers" (more merchant-focused)
- ⚠️ Less semantic for product listing page
- ⚠️ Caused duplication with head.html schema

**Conclusion:** ItemList is the right choice for `/product/` listing page!

---

## Benefits

### SEO:
- ✅ No more schema duplication
- ✅ Clean, single source of truth per page
- ✅ Correct semantic structure
- ✅ Better Google Rich Results display
- ✅ Prevents potential ranking penalty

### User Experience:
- ✅ Accurate product listings in search results
- ✅ No confusing duplicate product displays
- ✅ Consistent rating/review display

### Technical:
- ✅ Cleaner architecture - each page owns its schema
- ✅ Easier maintenance - no conflicts
- ✅ Dynamic rating system consistent across site

---

## Files Modified

1. `_includes/head.html` (line 36)
   - Removed `page.url contains '/product'` from conditional
   - Updated comment to reflect changes

2. `product.html` (lines 82-88)
   - Changed hardcoded rating to dynamic `product.rating`
   - Changed hardcoded reviewCount to dynamic `product.review_count`

---

## Related TODOs

- TODO-1518: Kontak Page Schema Fix (similar semantic mismatch)
- TODO-1517: Tentang Page Schema Fix (AboutPage implementation)
- Dynamic product rating (from earlier work)

---

## Testing Checklist

- [x] Rebuild successful
- [x] Only 1 ItemList schema on /product/
- [x] 5 Product schemas (not 10)
- [x] No LocalBusiness schema on /product/
- [x] Individual product pages still have LocalBusiness
- [x] Homepage still has LocalBusiness
- [x] Dynamic rating working
- [x] 76 total @type instances (correct)

---

**Status:** ✅ Completed
**Next:** Test dengan Google Rich Results Test untuk confirm duplikasi sudah hilang
