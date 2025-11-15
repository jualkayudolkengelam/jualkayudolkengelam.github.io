# Product List Component

Reusable partial untuk menampilkan daftar produk kayu dolken gelam dalam format tabel (desktop) dan card (mobile).

## File Location
`_includes/product-list.html`

## Features
- ✅ **Responsive Design**: Tabel di desktop, card di mobile
- ✅ **Auto-sorted**: Products sorted by price (low to high)
- ✅ **Popular highlight**: Produk populer dengan badge kuning
- ✅ **Customizable**: Title dan footer dapat dikustom
- ✅ **Bootstrap 5**: Menggunakan Bootstrap utilities untuk responsiveness
- ✅ **WhatsApp CTA**: Direct link ke WhatsApp untuk setiap produk

## Basic Usage

### Default (dengan semua features)
```liquid
{% include product-list.html %}
```

Output:
- Title: "Daftar Harga Kayu Dolken Gelam"
- Footer: Yes (harga dapat berubah disclaimer)

### Custom Title
```liquid
{% include product-list.html title="Harga Terbaru Kayu Dolken Gelam 2025" %}
```

### Tanpa Footer
```liquid
{% include product-list.html show_footer=false %}
```

### Custom Title + Tanpa Footer
```liquid
{% include product-list.html title="Produk Kayu Dolken" show_footer=false %}
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | String | "Daftar Harga Kayu Dolken Gelam" | Heading untuk tabel/card list |
| `show_footer` | Boolean | `true` | Tampilkan footer disclaimer |

## Responsive Behavior

### Desktop (≥768px)
- Displays as **table** with columns:
  - # (nomor urut)
  - Diameter
  - Panjang (4 Meter)
  - Harga per Batang
  - Kegunaan Umum
  - Aksi (Detail + WhatsApp buttons)

### Mobile (<768px)
- Displays as **card** stack with:
  - Product diameter as title
  - Badge number
  - Panjang info
  - Large price display
  - Usage info
  - Full-width action buttons

## Examples in Use

### 1. Product Page (`product.html`)
```liquid
---
layout: page
title: Produk Kayu Dolken Gelam
---

{% include product-list.html %}
```

### 2. Blog Post with Products (`_layouts/post-with-products.html`)
```liquid
<div class="container">
  {{ content }}

  <h2>Lihat Daftar Produk Kami</h2>
  {% include product-list.html title="Pilihan Kayu Dolken Kami" %}
</div>
```

### 3. Landing Page Custom Section
```liquid
<section class="products-section">
  <div class="container">
    {% include product-list.html title="Investasi Terbaik untuk Proyek Anda" show_footer=false %}
  </div>
</section>
```

### 4. Partial Product List (contoh: homepage)
```liquid
<div class="preview-section">
  <h2>Harga Kayu Dolken Gelam</h2>
  <p>Lihat daftar lengkap produk kami dengan harga terbaik.</p>

  {% include product-list.html %}

  <a href="/product/" class="btn btn-wood">Lihat Semua Produk</a>
</div>
```

## Data Source

Component ini menggunakan `site.products` collection yang didefinisikan di `_config.yml`:

```yaml
collections:
  products:
    output: true
    permalink: /product/:name/
```

Products sorted by `price` field:
```liquid
{% assign sorted_products = site.products | sort: "price" %}
```

## Styling

### CSS Classes Used
- `.product-card` - Card styling with hover effects
- `.text-wood` - Wood brown color (#8B4513)
- `.bg-wood` - Wood brown background
- `.table-hover` - Bootstrap table with hover
- `.border-warning` - Yellow border for popular products
- `.d-none .d-md-block` - Show only on desktop
- `.d-md-none` - Show only on mobile

### Breakpoint
```css
@media (min-width: 768px) {
  /* Desktop view (table) */
}

@media (max-width: 767px) {
  /* Mobile view (cards) */
}
```

## Bootstrap Utilities Used

- `d-none d-md-block` - Hidden on mobile, visible on desktop
- `d-md-none` - Visible on mobile, hidden on desktop
- `d-grid gap-2` - Stacked full-width buttons
- `table-responsive` - Horizontal scroll on small screens
- `shadow-sm` - Subtle shadow
- `border-0` - No border
- `mb-3`, `mb-5` - Margin bottom

## Maintenance

### Adding New Products
1. Create new file in `_products/` folder
2. Add required front matter (title, price, diameter, etc.)
3. Component will automatically include it (sorted by price)

### Modifying Component
Edit `_includes/product-list.html`

**Important:** Use `{% comment %}...{% endcomment %}` for documentation, NOT HTML comments `<!-- -->`, karena HTML comments akan execute Liquid tags di dalamnya.

## Troubleshooting

### Issue: Infinite loop / Stack level too deep
**Cause:** HTML comments in includes file executing Liquid tags
**Solution:** Use `{% comment %}{% endcomment %}` instead of `<!-- -->`

### Issue: Products not showing
**Check:**
1. `_products/` folder exists dengan `.md` files
2. Products have required front matter fields
3. Jekyll rebuild completed successfully

### Issue: Mobile view not working
**Check:**
1. Bootstrap CSS loaded correctly
2. Viewport meta tag in `<head>`
3. Browser width < 768px for testing

## Performance

- **File size**: ~5KB (minified HTML)
- **Requests**: 0 additional (inline, no external dependencies)
- **Render time**: ~50ms (5 products)
- **SEO**: Full semantic HTML, accessible

## Credits

Created: 2025-11-15
Updated: 2025-11-15
Author: Jual Kayu Dolken Gelam Development Team
