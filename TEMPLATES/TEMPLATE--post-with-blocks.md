---
# ============================================================================
# TEMPLATE: POST WITH BLOCK COMPONENTS
# ============================================================================
# File: TEMPLATE--post-with-blocks.md
# Purpose: Template untuk artikel menggunakan reusable block components
# Version: 1.0.0
# Date: 2025-11-21
#
# CARA KERJA SYSTEM:
#
# Template ini menggunakan BLOCK COMPONENTS yang sudah punya YAML structure
# di dalamnya. Anda TIDAK perlu menulis YAML panjang di frontmatter!
#
# Block components ada di: _includes/components/block--*.html
# Setiap block punya "COMPLETE YAML STRUCTURE" yang siap di-copy.
#
# WORKFLOW:
# ---------
# 1. Baca INSTRUKSI dari user (topik artikel yang diminta)
# 2. PILIH block components yang RELEVAN dengan instruksi
# 3. Buka block component di _includes/components/
# 4. Copy YAML structure dari section "COMPLETE YAML STRUCTURE"
# 5. Paste ke frontmatter dan isi dengan konten
# 6. Include block di content area
#
# DECISION LOGIC: Pilih Block Berdasarkan Instruksi
# --------------------------------------------------
#
# CONTOH 1:
# Instruksi: "Buatkan konten inspirasi dolken di pagar hotel"
# Decision:
#   ✅ Pakai: block--aplikasi-hotel.html (ada context: hotel)
#   ✅ Pakai: block--tips-desain.html (ada context: inspirasi)
#   ❌ TIDAK pakai: block--tentang-kota-ini.html (tidak ada lokasi spesifik)
#
# CONTOH 2:
# Instruksi: "Buatkan artikel inspirasi kayu dolken di Bandung"
# Decision:
#   ✅ Pakai: block--tentang-kota-ini.html (ada lokasi: Bandung!)
#   ✅ Pakai: block--aplikasi-hotel.html (aplikasi di area Bandung)
#   ✅ Pakai: block--tips-desain.html (inspirasi desain)
#
# CONTOH 3:
# Instruksi: "Case study implementasi dolken di Cafe XYZ"
# Decision:
#   ✅ Pakai: block--case-study.html (ada context: case study)
#   ❌ TIDAK pakai: block--tentang-kota-ini.html (tidak ada fokus lokasi)
#
# CONTOH 4:
# Instruksi: "Panduan lengkap kayu dolken untuk bisnis di Semarang"
# Decision:
#   ✅ Pakai: block--tentang-kota-ini.html (ada lokasi: Semarang!)
#   ✅ Pakai: block--aplikasi-hotel.html (aplikasi bisnis)
#   ✅ Pakai: block--tips-desain.html (panduan implementasi)
#   ❌ TIDAK pakai: block--mengapa-memilih.html (artikel tentang produk, bukan tentang toko)
#
# CONTOH 5:
# Instruksi: "Halaman About Us - Mengapa Anda harus beli dari kami"
# Decision:
#   ✅ Pakai: block--mengapa-memilih.html (tentang keunggulan PENJUAL/TOKO!)
#   ✅ Pakai: block--case-study.html (bukti kepuasan pelanggan)
#   ❌ TIDAK pakai: block--tentang-kota-ini.html (tidak ada fokus lokasi)
#
# KEYWORDS UNTUK DECISION:
# ------------------------
# - Lokasi spesifik (Bandung, Semarang, Jakarta, dll) → block--tentang-kota-ini.html
# - "mengapa pilih kami", "mengapa beli dari kami", "tentang penjual",
#   "kredibilitas toko", "keunggulan toko/kami" → block--mengapa-memilih.html
#   (CATATAN: Block ini tentang PENJUAL/TOKO, bukan tentang PRODUK)
# - "case study", "implementasi", "studi kasus" → block--case-study.html
# - "hotel", "cafe", "resort", "aplikasi" → block--aplikasi-hotel.html
# - "tips", "inspirasi", "desain", "ide" → block--tips-desain.html
#
# CARA MENDAPATKAN YAML STRUCTURE:
# ---------------------------------
# 1. Buka file block di _includes/components/block--{nama}.html
# 2. Scroll ke section "COMPLETE YAML STRUCTURE - COPY & PASTE KE FRONTMATTER"
# 3. Copy seluruh YAML structure
# 4. Paste ke frontmatter di bawah (section "BLOCK COMPONENTS YAML")
# 5. Ganti semua "isi ..." dengan konten Anda
#
# EXAMPLE WORKFLOW:
# -----------------
# 1. Buka: _includes/components/block--mengapa-memilih.html
# 2. Scroll ke section "COMPLETE YAML STRUCTURE"
# 3. Copy seluruh YAML structure
# 4. Paste ke frontmatter di bawah (setelah meta information)
# 5. Ganti semua "isi ..." dengan konten Anda
# 6. Tambahkan include di content area (lihat contoh di bawah)
#
# ============================================================================

# ============================================================================
# META INFORMATION (REQUIRED)
# ============================================================================
layout: node--post
title: "Isi title artikel (50-60 karakter, SEO-friendly)"
description: "Isi meta description (150-160 karakter) untuk SEO, mention topik & benefit"
date: YYYY-MM-DD  # Ganti dengan tanggal publikasi
category: Tutorial  # Options: Tutorial, Comparison, Guide, Tips, Review
tags:
  - "isi tag #1"
  - "isi tag #2"
  - "isi tag #3"
author: Admin
author_url: https://jualkayudolkengelam.github.io
image: /assets/images/posts/{slug}/{slug}-001.webp
images:
  - /assets/images/posts/{slug}/{slug}-001.webp
  - /assets/images/posts/{slug}/{slug}-002.webp
  - /assets/images/posts/{slug}/{slug}-003.webp
keywords: "isi keywords untuk SEO, pisahkan dengan koma"

# ============================================================================
# SOCIAL METRICS (REQUIRED)
# ============================================================================
like_count: 0
comment_count: 0
share_count: 0

# ============================================================================
# BLOCK COMPONENTS YAML
# ============================================================================
#
# INSTRUKSI:
# 1. Pilih block component yang dibutuhkan (lihat daftar di atas)
# 2. Buka file block component di _includes/components/
# 3. Copy YAML structure dari section "COMPLETE YAML STRUCTURE"
# 4. Paste di bawah ini dan isi dengan konten Anda
# 5. Tambahkan include di content area (lihat contoh di bawah)
#
# CONTOH: Menggunakan block--mengapa-memilih.html
# ------------------------------------------------
# Step 1: Buka _includes/components/block--mengapa-memilih.html
# Step 2: Copy YAML structure dari section "COMPLETE YAML STRUCTURE"
# Step 3: Paste di bawah ini:
#
# mengapa_memilih:
#   title: "Mengapa Hotel & Cafe Memilih Kayu Dolken?"
#   paragraph_1: "Kayu dolken gelam bukan sekadar elemen dekoratif..."
#   card_1:
#     title: "Estetika Natural yang Timeless"
#     icon: "bi-stars"
#     intro: "Tren desain saat ini mengarah pada:"
#     item_1:
#       icon: "bi-check-circle-fill"
#       color: "success"
#       title: "Biophilic Design"
#       deskripsi: "Membawa elemen alam ke dalam ruangan"
#     item_2:
#       icon: "bi-check-circle-fill"
#       color: "success"
#       title: "Sustainable Material"
#       deskripsi: "Konsumen lebih appreciate material eco-friendly"
#   card_2:
#     title: "Praktis dan Tahan Lama"
#     icon: "bi-shield-check"
#     intro: "Berbeda dengan dekorasi kayu biasa:"
#     item_1:
#       icon: "bi-droplet-fill"
#       color: "primary"
#       title: "Tahan Kelembaban Tinggi"
#       deskripsi: "Cocok untuk area basah seperti restroom"
#
# Step 4: Tambahkan include di content area (lihat bawah)
#
# ============================================================================

# PASTE YAML STRUCTURE DI SINI
# Copy dari block component yang Anda pilih

---

<!-- ========================================================================== -->
<!-- CONTENT AREA -->
<!-- ========================================================================== -->
<!--
INSTRUKSI:
1. Uncomment block component yang sudah Anda isi YAML-nya di frontmatter
2. Format: {% include components/block--{nama}.html %}
3. TIDAK perlu wrap dengan <section> - block sudah standalone
-->

<!-- Block: Mengapa Memilih -->
<!-- Uncomment jika sudah isi YAML "mengapa_memilih" di frontmatter -->
<!-- {% include components/block--mengapa-memilih.html %} -->

<!-- Block: Tentang Kota -->
<!-- Uncomment jika sudah isi YAML "tentang_kota" di frontmatter -->
<!-- {% include components/block--tentang-kota-ini.html %} -->

<!-- Block: Case Study -->
<!-- Uncomment jika sudah isi YAML "case_study" di frontmatter -->
<!-- {% include components/block--case-study.html %} -->

<!-- Block: Aplikasi Hotel/Cafe/Resort -->
<!-- Uncomment jika sudah isi YAML "aplikasi_hotel" di frontmatter -->
<!-- {% include components/block--aplikasi-hotel.html data=page.aplikasi_hotel %} -->

<!-- Block: Tips Desain -->
<!-- Uncomment jika sudah isi YAML "tips_desain" di frontmatter -->
<!-- {% include components/block--tips-desain.html data=page.tips_desain %} -->

<!-- ========================================================================== -->
<!-- CUSTOM CONTENT (OPTIONAL) -->
<!-- ========================================================================== -->
<!-- Tambahkan konten custom HTML/Markdown di sini jika diperlukan -->
