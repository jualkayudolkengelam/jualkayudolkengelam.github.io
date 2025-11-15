# TODO: Cara Update Harga Produk

**File:** TODO-1511-cara-update-harga.md
**Date:** 2025-11-15
**Category:** Price Management
**Status:** ✅ Implemented

---

## Overview

Sistem harga sudah dibuat dinamis. Anda hanya perlu update harga di satu tempat saja (file product markdown), dan semua halaman akan otomatis ter-update.

---

## Lokasi File Produk

Semua data product (termasuk harga) tersimpan di folder:

```
public_html/_products/
├── kayu-dolken-2-3cm.md
├── kayu-dolken-4-6cm.md
├── kayu-dolken-6-8cm.md
├── kayu-dolken-8-10cm.md
└── kayu-dolken-10-12cm.md
```

---

## Cara Update Harga

### Step 1: Edit File Produk

Buka file product yang ingin diubah harganya, misalnya:

```bash
nano /home/mkt01/Public/jualkayudolkengelam.github.io/public_html/_products/kayu-dolken-8-10cm.md
```

### Step 2: Ubah Nilai Price

Cari baris `price:` di bagian front matter (YAML header di atas):

```yaml
---
layout: product
title: Kayu Dolken Gelam Diameter 8-10 cm
description: ...
price: 85000              # <-- UBAH NILAI INI
diameter: 8 - 10 cm
image: /assets/images/products/jual-kayu-dolken-gelam-8-10cm-001.jpeg
sku: DOLKEN-8-10
popular: true
---
```

**Contoh:**
- Harga lama: `price: 85000`
- Harga baru: `price: 90000`

**PENTING:**
- Jangan pakai titik atau koma pemisah ribuan
- Hanya tulis angka saja (contoh: 90000, bukan 90.000)
- Sistem akan otomatis format dengan titik pemisah ribuan (Rp 90.000)

### Step 3: Rebuild Jekyll

Setelah mengubah harga, rebuild site:

```bash
cd /home/mkt01/Public/jualkayudolkengelam.github.io/public_html
./rebuild.sh
```

### Step 4: Verifikasi

Cek apakah harga sudah berubah di semua halaman:

1. **Homepage** - http://jualkayudolkengelam.github.io.local/#product
2. **Daftar Produk** - http://jualkayudolkengelam.github.io.local/product/
3. **Halaman Detail** - http://jualkayudolkengelam.github.io.local/product/kayu-dolken-8-10cm/

---

## Halaman Yang Akan Ter-Update Otomatis

Ketika Anda mengubah harga di file `_products/*.md`, halaman-halaman berikut akan otomatis ter-update:

1. ✅ **Homepage (`index.html`)** - Section "Daftar Harga Kayu Dolken Gelam"
   - Card product dengan harga
   - Link WhatsApp dengan harga

2. ✅ **Daftar Produk (`product.html`)** - Tabel daftar harga
   - Kolom harga di tabel
   - Link WhatsApp dengan harga

3. ✅ **Halaman Detail Produk (`_layouts/product.html`)** - Individual product page
   - Harga di header product
   - Link WhatsApp dengan harga
   - Schema.org markup dengan harga

4. ✅ **Schema.org Markup** - SEO structured data
   - Homepage ItemList
   - Individual Product pages
   - Google Rich Snippets

---

## Contoh Update Semua Harga

Jika Anda ingin update semua harga sekaligus (misalnya naik 10%):

### File: kayu-dolken-2-3cm.md
```yaml
price: 15000   # Dari 15.000 tetap atau naik jadi 16500
```

### File: kayu-dolken-4-6cm.md
```yaml
price: 35000   # Dari 35.000 naik jadi 38500
```

### File: kayu-dolken-6-8cm.md
```yaml
price: 60000   # Dari 60.000 naik jadi 66000
```

### File: kayu-dolken-8-10cm.md (POPULER)
```yaml
price: 85000   # Dari 85.000 naik jadi 93500
```

### File: kayu-dolken-10-12cm.md
```yaml
price: 120000  # Dari 120.000 naik jadi 132000
```

Setelah edit semua file, jalankan sekali:
```bash
./rebuild.sh
```

Dan **SEMUA halaman** akan ter-update dengan harga baru!

---

## Technical Details

### Custom Rupiah Filter

Sistem menggunakan custom Ruby plugin untuk format harga:

**File:** `_plugins/currency_filter.rb`

```ruby
module Jekyll
  module CurrencyFilter
    def rupiah(input)
      value = input.to_i
      value.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    end
  end
end
```

**Usage di template:**
```liquid
{{ product.price | rupiah }}
```

**Output:**
- Input: `85000`
- Output: `85.000`

### Dynamic Loop dari Collection

Homepage dan halaman product menggunakan loop dari collection:

```liquid
{% assign sorted_products = site.products | sort: "price" %}
{% for product in sorted_products %}
  <div class="product-price">Rp {{ product.price | rupiah }}</div>
  <a href="{{ product.url }}">{{ product.title }}</a>
{% endfor %}
```

**Keuntungan:**
- ✅ Harga otomatis update di semua halaman
- ✅ Tidak perlu edit banyak file
- ✅ Konsistensi data terjamin
- ✅ Easy maintenance

---

## Troubleshooting

### Harga tidak berubah setelah rebuild?

1. **Clear browser cache** - Tekan Ctrl+Shift+R atau Cmd+Shift+R
2. **Cek file sudah tersimpan** - Pastikan perubahan di file `.md` sudah di-save
3. **Cek syntax YAML** - Pastikan tidak ada error di front matter
4. **Lihat error log** - Cek output dari `./rebuild.sh`

### Format harga salah (tidak ada titik)?

Plugin `_plugins/currency_filter.rb` mungkin tidak loaded. Pastikan:
- Folder `_plugins` ada
- File `currency_filter.rb` ada dan readable
- Jekyll di-restart (rebuild ulang)

---

## Best Practices

1. **Backup dulu** - Sebelum update harga, backup file product
2. **Test di local** - Rebuild dan test di localhost dulu
3. **Update bertahap** - Jika tidak yakin, update satu product dulu
4. **Dokumentasi** - Catat perubahan harga di changelog
5. **Commit to Git** - Versioning perubahan harga

---

## Changelog Harga

### 2025-11-15 - Harga Aktif
- 2-3 cm: Rp 15.000
- 4-6 cm: Rp 25.000
- 6-8 cm: Rp 30.000
- 8-10 cm: Rp 35.000 (POPULER)
- 10-12 cm: Rp 45.000

### Future Updates
(Dokumentasikan perubahan harga di sini)

**PENTING:** Setiap kali update harga, pastikan rebuild site dengan `./rebuild.sh`

---

**Last Updated:** 2025-11-15
**Maintainer:** Amirudin Abdul Karim
