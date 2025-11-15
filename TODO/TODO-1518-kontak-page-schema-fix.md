# TODO-1518: Kontak Page Schema.org Fix

**Date:** 2025-11-16
**Status:** ✅ Completed
**Type:** SEO / Schema.org Fix

---

## Task Summary

Fix schema.org semantic mismatch pada halaman `/kontak/` - menghapus Product/OfferCatalog schema yang tidak sesuai dengan konten halaman, dan menggantinya dengan `ContactPage` + `LocalBusiness` (tanpa catalog).

---

## Problem Identified

### Error:
- Halaman `/kontak/` menampilkan **LocalBusiness + OfferCatalog dengan Product listings**
- Schema menampilkan "Cuplikan produk" dan "Listingan penjual"
- **Semantic mismatch**: Halaman kontak tidak berisi listing produk, tapi schema.org mengatakan ada product catalog

### Root Cause:
Conditional logic di `_includes/head.html` line 36 memasukkan `/kontak/` dalam kondisi yang menampilkan OfferCatalog:
```liquid
{% if page.url == '/' or page.url contains '/product' or page.url contains '/kontak' or page.layout == 'product' %}
  <!-- LocalBusiness + OfferCatalog -->
{% endif %}
```

### Impact:
- Google Rich Results menampilkan product schema pada halaman yang bukan halaman produk
- Confusing untuk search engines - halaman kontak kok ada product catalog?
- Potential SEO penalty untuk semantic mismatch

---

## Solution Implemented

### Files Modified:
`_includes/head.html`

### Changes Made:

#### 1. Removed `/kontak` from OfferCatalog Condition (line 35)
**Before:**
```liquid
{% if page.url == '/' or page.url contains '/product' or page.url contains '/kontak' or page.layout == 'product' %}
```

**After:**
```liquid
{% if page.url == '/' or page.url contains '/product' or page.layout == 'product' %}
```

✅ Halaman kontak tidak lagi menampilkan OfferCatalog

#### 2. Added ContactPage Schema (lines 220-285)
**New Schema Block:**
```liquid
{% if page.url == '/kontak' or page.url == '/kontak/' %}
  <!-- Schema.org ContactPage with LocalBusiness -->
  <script type="application/ld+json">
  {
    "@type": "ContactPage",
    "name": "Hubungi Kami",
    "description": "...",
    "url": "...",
    "mainEntity": {
      "@type": "LocalBusiness",
      "name": "...",
      "telephone": "...",
      "address": { ... },
      "geo": { ... },
      "openingHoursSpecification": { ... },
      "priceRange": "...",
      "areaServed": [ ... ]
    }
  }
  </script>
{% endif %}
```

---

## Schema.org Structure

### ContactPage (Top Level):
- **@type:** `ContactPage` - Semantic type untuk halaman kontak
- **name:** Page title (from page.title)
- **description:** Page description (from page.description)
- **url:** Canonical URL
- **mainEntity:** LocalBusiness entity

### LocalBusiness (mainEntity):
**Included:**
- ✅ `name` - Business name
- ✅ `description` - Business description
- ✅ `url` - Website URL
- ✅ `telephone` - Phone number (+62 813-1140-0177)
- ✅ `image` - Business image
- ✅ `address` - PostalAddress (Kota Serang, Banten)
- ✅ `geo` - GeoCoordinates (latitude, longitude)
- ✅ `openingHoursSpecification` - Business hours (Mon-Sat 08:00-17:00)
- ✅ `priceRange` - Price range (Rp 15.000 - Rp 45.000)
- ✅ `areaServed` - Service areas (Jakarta, Jawa Barat, Banten, etc.)

**NOT Included:**
- ❌ `hasOfferCatalog` - REMOVED! (tidak relevan untuk halaman kontak)
- ❌ Product listings

---

## Additional Schema on Contact Page

### FAQPage Schema (in kontak.html itself):
Halaman kontak juga memiliki FAQPage schema terpisah (lines 239-286 di kontak.html) dengan 5 pertanyaan:
1. Berapa minimal pemesanan kayu dolken gelam?
2. Apakah harga sudah termasuk ongkir?
3. Berapa lama pengiriman ke Jakarta?
4. Apakah bisa custom ukuran panjang?
5. Bagaimana cara pembayarannya?

Total schema.org pada halaman kontak:
- ✅ **ContactPage** (with LocalBusiness mainEntity) - from head.html
- ✅ **FAQPage** (with 5 Question/Answer pairs) - from kontak.html

---

## Why ContactPage Instead of Just LocalBusiness?

### Benefits of ContactPage:
1. **Semantic Correctness** - Tells search engines this is a contact/inquiry page
2. **Better Indexing** - Google understands page purpose immediately
3. **Rich Results Potential** - Can appear in contact-related searches
4. **User Intent Matching** - Matches user intent to contact the business

### Why Keep LocalBusiness?
1. **Contact Info** - Provides phone, address, opening hours
2. **Local SEO** - Helps with local search rankings
3. **NAP Consistency** - Name, Address, Phone across all pages
4. **Knowledge Graph** - Contributes to business knowledge graph

### Why Remove OfferCatalog?
1. **No Product Listings** - Contact page doesn't display products
2. **Semantic Mismatch** - Schema should match actual page content
3. **Google Guidelines** - Only use Product schema where products are displayed
4. **User Experience** - Misleading to show product rich results for contact page

---

## Verification

**Build Status:** ✅ Success
```bash
./rebuild.sh
# Build completed successfully!
# Generated 132 files (29M)
```

**Schema.org Count on /kontak/:**
- Total @type instances: 22
  - ContactPage: 1
  - LocalBusiness: 1
  - PostalAddress: 1
  - GeoCoordinates: 1
  - OpeningHoursSpecification: 1
  - City/State (areaServed): 6
  - FAQPage: 1
  - Question: 5
  - Answer: 5

**Verification Commands:**
```bash
# Verify ContactPage schema exists
grep '@type.*ContactPage' _site/kontak/index.html
✅ Found

# Verify NO OfferCatalog or Product schema
grep -i 'OfferCatalog\|"Product"' _site/kontak/index.html
✅ Only found HTML comment, no actual schema

# Count total schema types
grep -c '@type' _site/kontak/index.html
✅ 22 types (correct)
```

**Generated HTML Path:**
`_site/kontak/index.html`

**Live URL:**
`https://jualkayudolkengelam.github.io/kontak/`

---

## Before vs After Comparison

### Before (Wrong):
```json
{
  "@type": "LocalBusiness",
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Product",
          ...
        }
      },
      ...
    ]
  }
}
```
❌ Product catalog pada halaman kontak (semantic mismatch!)

### After (Correct):
```json
{
  "@type": "ContactPage",
  "mainEntity": {
    "@type": "LocalBusiness",
    "name": "...",
    "telephone": "...",
    "address": { ... },
    "geo": { ... }
    // NO hasOfferCatalog!
  }
}
```
✅ Contact page schema yang semantic correct!

---

## Updated Schema.org Coverage

| Page Type | URL | Schema.org Type | Has Products? |
|-----------|-----|-----------------|---------------|
| Homepage | `/` | LocalBusiness + OfferCatalog | ✅ Yes |
| Product Listing | `/product/` | LocalBusiness + OfferCatalog | ✅ Yes |
| Individual Product | `/product/*` | LocalBusiness + OfferCatalog | ✅ Yes |
| **Contact** | `/kontak/` | **ContactPage + LocalBusiness** | ❌ No (FIXED) |
| Blog Listing | `/blog/` | CollectionPage + ItemList | ❌ No |
| Individual Post | `/blog/*/*` | BlogPosting | ❌ No |
| About Page | `/tentang/` | AboutPage + Organization | ❌ No |

**Key Principle:** Schema.org harus match dengan konten yang sebenarnya ada di halaman!

---

## Benefits

### SEO:
- ✅ Semantic correctness - schema matches page content
- ✅ No more misleading product rich results on contact page
- ✅ Better local SEO with LocalBusiness data
- ✅ FAQ rich results from FAQPage schema
- ✅ Compliance with Google Rich Results guidelines

### User Experience:
- ✅ Search results accurately reflect page content
- ✅ Users see contact info in rich results, not product listings
- ✅ Better click-through rate from accurate expectations

### Technical:
- ✅ Follows schema.org best practices
- ✅ Consistent semantic structure across site
- ✅ Clean separation of concerns

---

## Related Files

- Template: `_includes/head.html` (lines 35, 220-285)
- Page: `kontak.html` (has FAQPage schema inside)
- Build script: `rebuild.sh`

---

## Related TODOs

- TODO-1517: Tentang Page Schema Fix (AboutPage)
- TODO-1516: Area Pengiriman Cards Layout
- TODO-1513: Blog Post Checklist (like counts)

---

**Status:** ✅ Completed
**Next:** Monitor Google Search Console untuk memastikan tidak ada error schema.org
