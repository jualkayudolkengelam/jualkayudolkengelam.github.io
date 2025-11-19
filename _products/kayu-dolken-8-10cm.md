---
layout: node--product
title: Jual Kayu Dolken Gelam Diameter 8-10 cm
description: Jual kayu dolken gelam diameter 8-10 cm panjang 4 meter. Produk paling populer untuk tiang pancang dan konstruksi permanen. Harga sudah termasuk ongkir. Bayar setelah barang sampai.
price: 35000
diameter: 8 - 10 cm
image: /assets/images/products/jual-kayu-dolken-gelam-8-10cm-001.jpeg
images:
  - /assets/images/products/jual-kayu-dolken-gelam-8-10cm-001.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-8-10cm-002.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-8-10cm-003.jpeg
  - /assets/images/products/jual-kayu-dolken-gelam-8-10cm-004.jpeg
sku: DOLKEN-8-10
popular: true
rating: 4.8
review_count: 91
total_updates: 0
show_bulk_offer: true

# Product Description
deskripsi_intro: "Kayu dolken gelam diameter 8-10 cm adalah produk paling populer kami! ⭐ Ukuran ini menjadi favorit kontraktor dan developer karena memberikan kekuatan optimal untuk berbagai jenis konstruksi permanen. Diameter 8-10 cm adalah pilihan terbaik untuk tiang pancang fondasi dan konstruksi struktural yang membutuhkan daya tahan maksimal."

# Technical Specifications
spesifikasi:
  panjang: "4 meter standar"
  material: "100% kayu gelam asli pilihan"
  kondisi: "Kering udara, siap pakai"
  kekuatan: "Maksimal untuk konstruksi permanen"
  ketahanan: "30-50 tahun"
  kepadatan: "Tinggi (tenggelam di air)"
  finishing: "Natural (dapat dicat/divernish)"

# Product Advantages
keunggulan:
  - judul: "Keunggulan Utama Produk"
    aplikasi:
      - "Produk paling laris dan populer"
      - "Kayu gelam asli kualitas super premium"
      - "Diameter ideal untuk tiang pancang"
      - "Panjang standar 4 meter"
      - "Kekuatan struktural maksimal"
      - "Tahan 30+ tahun"
      - "Harga sudah termasuk ongkir"
      - "Pembayaran setelah barang sampai"
  - judul: "Produk Paling Laris ⭐"
    deskripsi: "Dipercaya oleh ratusan kontraktor dan developer untuk berbagai proyek konstruksi. Ukuran ini menjadi standar industri untuk tiang pancang kayu."
  - judul: "Kekuatan Struktural Terbaik"
    deskripsi: "Diameter 8-10 cm memberikan rasio kekuatan terhadap berat yang optimal. Cocok untuk konstruksi yang membutuhkan daya dukung maksimal dengan efisiensi biaya terbaik."
  - judul: "Aplikasi Profesional"
    aplikasi:
      - "Tiang pancang fondasi rumah"
      - "Konstruksi dermaga dan pelabuhan"
      - "Jembatan kayu permanen"
      - "Pagar industrial dan perumahan"
      - "Tiang utilitas (listrik, lampu jalan)"
      - "Turap dan penahan tanah"
      - "Konstruksi bangunan kayu"
      - "Proyek sipil dan infrastruktur"
  - judul: "Daya Tahan Legendaris"
    deskripsi: "Kayu gelam diameter 8-10 cm dapat bertahan 30-50 tahun bahkan dalam kondisi terendam air atau kontak langsung dengan tanah. Tidak perlu pengawetan kimia!"

# Recommendations Array (Usage + Why Popular)
rekomendasi:
  - tipe: "penggunaan"
    sections:
      - heading: "Untuk Tiang Pancang Fondasi:"
        deskripsi: "Ideal untuk fondasi rumah 1-2 lantai. Dapat dipancang 1.5-2.5 meter ke dalam tanah. Jarak ideal antar tiang 1.5-2 meter sesuai beban struktur."
      - heading: "Untuk Dermaga:"
        deskripsi: "Sangat cocok untuk konstruksi dermaga permanen. Tahan terendam air laut puluhan tahun tanpa pembusukan."
      - heading: "Untuk Pagar Industrial:"
        deskripsi: "Memberikan kekuatan dan keamanan maksimal. Jarak ideal 20-30 cm untuk pagar yang sangat kokoh."
  - tipe: "why_popular"
    judul: "Mengapa Diameter 8-10 cm Paling Populer?"
    sections:
      - items:
          - "Keseimbangan Sempurna - Kuat namun tidak terlalu berat untuk handling"
          - "Standar Industri - Banyak digunakan kontraktor profesional"
          - "Cost Effective - Harga per kekuatan paling ekonomis"
          - "Versatile - Cocok untuk hampir semua aplikasi konstruksi"
          - "Ketersediaan - Stok selalu ready untuk proyek besar"
---

<section id="product-deskripsi">
{% include products/block--product-deskripsi.html %}
</section>

<section id="product-keunggulan">
{% include products/block--product-keunggulan.html %}
</section>

<section id="product-spesifikasi-teknis">
{% include products/block--product-spesifikasi-teknis.html %}
</section>

<section id="product-harga-pengiriman">
{% include products/block--product-harga-pengiriman.html %}
</section>

{% for rekomendasi_item in page.rekomendasi %}
<section id="product-rekomendasi-{{ forloop.index }}">
{% assign page_rekomendasi_temp = rekomendasi_item %}
{% assign page.rekomendasi = page_rekomendasi_temp %}
{% include products/block--product-rekomendasi.html %}
</section>
{% endfor %}
{% assign page.rekomendasi = page.rekomendasi %}

<section id="product-cara-pemesanan">
{% include products/block--product-cara-pemesanan.html %}
</section>

<section id="product-area-pengiriman">
{% include products/block--product-area-pengiriman.html %}
</section>
