---
# ============================================================================
# MULTI-PURPOSE CONTENT GENERATION WORKFLOW
# ============================================================================
# File: TEMPLATE--multi-purpose.md
# Purpose: Workflow instructions untuk AI Agent (Claude) saat generate konten
# Version: 2.0.0
# Date: 2025-11-21
#
# ============================================================================
# CARA KERJA SYSTEM (FOR AI AGENT)
# ============================================================================
#
# Template ini adalah WORKFLOW INSTRUCTIONS untuk AI Agent.
# Saat user request konten baru, ikuti langkah-langkah berikut:
#
# ============================================================================
# WORKFLOW STEPS
# ============================================================================
#
# STEP 1: TANGKAP KEBUTUHAN USER
# -------------------------------
# Dari instruksi user, identifikasi:
# - Topik artikel (tentang apa?)
# - Target audience (untuk siapa?)
# - Lokasi (ada nama kota/daerah spesifik?)
# - Tujuan (informasi, promosi, tutorial, case study?)
# - Scope (produk saja, toko, lokasi, atau kombinasi?)
#
# Contoh instruksi user:
# - "Buatkan artikel tentang inspirasi dolken di hotel Bandung"
# - "Generate landing page untuk toko kami"
# - "Case study implementasi dolken di Cafe XYZ"
#
# STEP 2: SCAN AVAILABLE BLOCKS
# ------------------------------
# Scan folder: _includes/components/
# Pattern: block--*.html
#
# Untuk setiap block yang ditemukan:
# 1. Read file untuk mendapatkan @description
# 2. Extract informasi:
#    - Purpose (untuk apa block ini?)
#    - Heading structure (berapa H2, H3, H4, dll?)
#    - Cards (berapa cards?)
#    - YAML key (key apa yang dipakai di frontmatter?)
#    - Use cases (kapan block ini cocok dipakai?)
#
# STEP 3: ANALISA & MATCH BLOCKS
# -------------------------------
# Berdasarkan kebutuhan user (Step 1) dan available blocks (Step 2):
# - Tentukan blocks mana yang SANGAT RELEVAN (✅)
# - Tentukan blocks mana yang OPTIONAL/CONDITIONAL (⚠️)
# - Tentukan blocks mana yang TIDAK RELEVAN (❌)
#
# Kriteria matching:
# - Lokasi spesifik disebutkan? → Pertimbangkan block--tentang-kota-ini.html
# - Fokus pada produk? → Pertimbangkan block--mengapa-memilih-dolken.html
# - Fokus pada toko/penjual? → Pertimbangkan block--mengapa-memilih-kami.html
# - Ada case study? → Pertimbangkan block--case-study.html
# - Ada aplikasi/use cases? → Pertimbangkan block--aplikasi-hotel.html
# - Ada tips/inspirasi? → Pertimbangkan block--tips-desain.html
#
# STEP 4: TAWARKAN BLOCKS KE USER
# --------------------------------
# Present hasil analisa ke user dalam format:
#
# ```
# 📊 ANALISA KEBUTUHAN:
# - Topik: [topik yang diidentifikasi]
# - Lokasi: [ada/tidak ada]
# - Fokus: [produk/toko/lokasi/kombinasi]
# - Tujuan: [informasi/promosi/tutorial/dll]
#
# 🎯 BLOCKS YANG SAYA SARANKAN:
#
# ✅ SANGAT RELEVAN (akan dipakai):
# 1. block--{nama}.html
#    - Purpose: [jelaskan untuk apa]
#    - Alasan: [mengapa block ini cocok]
#    - Headings: [struktur heading]
#    - Cards: [jumlah cards]
#
# 2. block--{nama}.html
#    - Purpose: ...
#    - Alasan: ...
#
# ⚠️ OPTIONAL (bisa ditambahkan):
# 1. block--{nama}.html
#    - Purpose: ...
#    - Kondisi: [kapan block ini berguna]
#
# ❌ TIDAK DIPAKAI:
# 1. block--{nama}.html
#    - Alasan: [mengapa tidak cocok]
#
# ❓ KONFIRMASI:
# Apakah Anda setuju dengan pilihan blocks di atas?
# - Ketik "OK" untuk lanjut generate
# - Atau sebutkan revisi yang Anda inginkan
# ```
#
# STEP 5: TUNGGU APPROVAL USER
# -----------------------------
# Tunggu response user:
# - Jika "OK" / "Setuju" / "Ya" → Lanjut ke Step 6
# - Jika ada revisi → Kembali ke Step 3 dengan adjustment
# - Jika user minta tambah/kurangi block tertentu → Adjust dan konfirmasi ulang
#
# STEP 6: GENERATE KONTEN
# ------------------------
# Setelah blocks disetujui:
#
# 6.1. Buat file artikel baru:
#     - Path: _posts/YYYY-MM-DD-{slug}.md
#     - Slug: generate dari topik artikel
#
# 6.2. Isi Meta Information:
#     - title: Generate title SEO-friendly (50-60 char)
#     - description: Generate meta description (150-160 char)
#     - category: Tentukan category yang sesuai
#     - tags: Generate 3-4 tags relevan
#     - date: Gunakan tanggal hari ini
#     - keywords: Generate 6-8 keywords
#
# 6.3. Untuk setiap block yang disetujui:
#     a. Buka file block di _includes/components/block--{nama}.html
#     b. Read section "COMPLETE YAML STRUCTURE"
#     c. Copy YAML structure
#     d. Generate konten untuk setiap field dalam YAML
#     e. Paste ke frontmatter
#
# 6.4. Di content area:
#     - Uncomment include untuk blocks yang dipakai
#     - Atur urutan blocks yang logical
#
# 6.5. Generate konten berkualitas:
#     - Setiap heading harus punya paragraph setelahnya (SEO!)
#     - Konten harus natural, bukan template-like
#     - Gunakan data/info spesifik, bukan placeholder
#     - Jika lokasi spesifik, sebutkan detail lokasi nyata
#
# ============================================================================
# CONTOH WORKFLOW EXECUTION
# ============================================================================
#
# CONTOH 1: Product Article Request
# ----------------------------------
#
# USER REQUEST:
# "Buatkan artikel tentang inspirasi dolken untuk pagar hotel"
#
# STEP 1 - TANGKAP KEBUTUHAN:
# - Topik: Inspirasi penggunaan dolken untuk pagar
# - Target: Pemilik hotel, designer
# - Lokasi: Tidak ada lokasi spesifik
# - Tujuan: Inspirasi & ide implementasi
# - Scope: Fokus pada produk dan aplikasinya
#
# STEP 2 - SCAN BLOCKS:
# [AI scan folder _includes/components/]
# Found:
# - block--tentang-kota-ini.html (info kota - TIDAK RELEVAN, tidak ada lokasi)
# - block--mengapa-memilih-kami.html (tentang toko - TIDAK RELEVAN, fokus produk)
# - block--mengapa-memilih-dolken.html (keunggulan produk - RELEVAN!)
# - block--case-study.html (studi kasus - OPTIONAL)
# - block--aplikasi-hotel.html (aplikasi di hotel - SANGAT RELEVAN!)
# - block--tips-desain.html (tips & inspirasi - SANGAT RELEVAN!)
#
# STEP 3 - ANALISA:
# ✅ SANGAT RELEVAN:
# - block--mengapa-memilih-dolken.html (jelaskan keunggulan dolken untuk pagar)
# - block--aplikasi-hotel.html (showcase berbagai aplikasi di hotel)
# - block--tips-desain.html (ide kreatif & tips implementasi)
#
# ⚠️ OPTIONAL:
# - block--case-study.html (jika ada data case study nyata)
#
# ❌ TIDAK RELEVAN:
# - block--tentang-kota-ini.html (tidak ada lokasi spesifik)
# - block--mengapa-memilih-kami.html (bukan promosi toko)
#
# STEP 4 - TAWARKAN:
# [AI present recommendation ke user - format seperti di Step 4]
#
# STEP 5 - APPROVAL:
# User: "OK, tapi tambahkan case study juga"
# [AI adjust: pindahkan case-study dari optional ke main blocks]
#
# STEP 6 - GENERATE:
# [AI generate file lengkap dengan semua YAML dan content]
#
# ---
#
# CONTOH 2: Location-specific Request
# ------------------------------------
#
# USER REQUEST:
# "Buatkan artikel inspirasi kayu dolken di Bandung"
#
# STEP 1 - TANGKAP KEBUTUHAN:
# - Topik: Inspirasi dolken
# - Target: Pembaca di Bandung
# - Lokasi: BANDUNG (spesifik!)
# - Tujuan: Inspirasi + local authority
# - Scope: Produk + lokasi
#
# STEP 2 - SCAN BLOCKS:
# [AI scan folder]
#
# STEP 3 - ANALISA:
# ✅ SANGAT RELEVAN:
# - block--tentang-kota-ini.html (info Bandung - WAJIB ada lokasi!)
# - block--mengapa-memilih-dolken.html (keunggulan dolken)
# - block--aplikasi-hotel.html (aplikasi di area Bandung)
# - block--tips-desain.html (inspirasi desain)
#
# ❌ TIDAK RELEVAN:
# - block--mengapa-memilih-kami.html (bukan promosi toko)
# - block--case-study.html (tidak diminta case study)
#
# STEP 4 - TAWARKAN:
# [Present dengan 4 blocks]
#
# STEP 5 - APPROVAL:
# User: "Setuju"
#
# STEP 6 - GENERATE:
# [Generate dengan special attention to Bandung-specific content]
#
# ---
#
# CONTOH 3: About Us Page Request
# --------------------------------
#
# USER REQUEST:
# "Buatkan halaman About Us untuk website kami"
#
# STEP 1 - TANGKAP KEBUTUHAN:
# - Topik: Profil perusahaan
# - Target: Prospective customers
# - Lokasi: [Tanya user jika belum jelas]
# - Tujuan: Membangun trust & kredibilitas
# - Scope: Fokus pada TOKO/PENJUAL
#
# STEP 2 - SCAN BLOCKS:
# [AI scan folder]
#
# STEP 3 - ANALISA:
# ✅ SANGAT RELEVAN:
# - block--mengapa-memilih-kami.html (CORE - tentang toko!)
# - block--case-study.html (social proof)
#
# ⚠️ OPTIONAL:
# - block--tentang-kota-ini.html (jika toko lokal di kota tertentu)
#
# ❌ TIDAK RELEVAN:
# - block--mengapa-memilih-dolken.html (bukan tentang produk)
# - block--aplikasi-hotel.html (bukan showcase produk)
# - block--tips-desain.html (bukan tips page)
#
# STEP 4 - TAWARKAN:
# [Present dengan catatan: need to know if local business]
#
# STEP 5 - APPROVAL:
# User: "Ya, kami di Semarang"
# [AI adjust: tambahkan block--tentang-kota-ini.html dengan nama_kota: Semarang]
#
# STEP 6 - GENERATE:
# [Generate dengan 3 blocks termasuk info Semarang]
#
# ============================================================================
# DECISION RULES (FOR AI REFERENCE)
# ============================================================================
#
# Quick reference untuk matching blocks:
#
# IF lokasi_spesifik_detected:
#   ✅ WAJIB: block--tentang-kota-ini.html
#   Set: nama_kota = [nama kota yang disebutkan]
#
# IF topik_about_toko OR topik_about_penjual OR topik_kredibilitas:
#   ✅ WAJIB: block--mengapa-memilih-kami.html
#   ❌ JANGAN: block--mengapa-memilih-dolken.html
#
# IF topik_about_produk OR topik_panduan_produk OR topik_keunggulan_produk:
#   ✅ WAJIB: block--mengapa-memilih-dolken.html
#   ❌ JANGAN: block--mengapa-memilih-kami.html
#
# IF topik_case_study OR topik_implementasi_nyata OR topik_testimonial:
#   ✅ WAJIB: block--case-study.html
#
# IF topik_aplikasi OR topik_use_case OR mention_hotel_cafe_resort:
#   ✅ STRONGLY RECOMMENDED: block--aplikasi-hotel.html
#
# IF topik_tips OR topik_inspirasi OR topik_ide_desain:
#   ✅ STRONGLY RECOMMENDED: block--tips-desain.html
#
# IF content_type == "landing_page":
#   ✅ RECOMMENDED: Kombinasi multiple blocks untuk completeness
#
# IF content_type == "about_us":
#   ✅ WAJIB: block--mengapa-memilih-kami.html
#   ✅ RECOMMENDED: block--case-study.html (social proof)
#   ⚠️ CONDITIONAL: block--tentang-kota-ini.html (if local business)
#
# ============================================================================
# QUALITY GUIDELINES (SAAT GENERATE KONTEN)
# ============================================================================
#
# 1. SEO REQUIREMENTS:
#    - Setiap H2 HARUS punya minimal 1 paragraph setelahnya
#    - Setiap H3 HARUS punya minimal 1 paragraph setelahnya
#    - Setiap H4 HARUS punya minimal 1 paragraph setelahnya
#    - Total paragraphs harus sesuai dengan struktur block
#
# 2. CONTENT QUALITY:
#    - Jangan gunakan placeholder seperti "isi dengan...", "contoh..."
#    - Generate konten real, specific, detailed
#    - Jika lokasi spesifik, sebutkan landmark/info nyata tentang kota tersebut
#    - Gunakan data/statistik jika relevan
#    - Natural writing style, bukan robotic
#
# 3. YAML COMPLETENESS:
#    - Isi SEMUA required fields dalam YAML structure
#    - Jangan skip card atau detail
#    - Jika block support 6 cards, generate 6 cards (kecuali user specify otherwise)
#
# 4. IMAGE PATHS:
#    - Generate proper image paths: /assets/images/posts/{slug}/{slug}-001.webp
#    - {slug} = slug artikel yang di-generate
#    - Sesuaikan jumlah images dengan kebutuhan (minimal 3-4)
#
# 5. HEADING HIERARCHY:
#    - Pastikan hierarchy H2→H3→H4→H5 correct
#    - Tidak boleh skip level (misal: H2→H4 tanpa H3)
#
# ============================================================================
# ERROR HANDLING
# ============================================================================
#
# IF user_request_unclear:
#   - Tanya user untuk klarifikasi
#   - "Untuk generate konten yang tepat, bisa Anda jelaskan lebih detail tentang:"
#   - List pertanyaan spesifik
#
# IF no_matching_blocks_found:
#   - Inform user bahwa tidak ada block yang exact match
#   - Tawarkan blocks yang paling mendekati
#   - Atau suggest untuk create custom content tanpa blocks
#
# IF user_reject_all_suggestions:
#   - Tanya user: "Block mana yang Anda inginkan?"
#   - List semua available blocks dengan descriptions
#   - Biarkan user pilih sendiri
#
# IF technical_error_reading_blocks:
#   - Fallback ke generate konten sederhana tanpa blocks
#   - Atau minta user untuk specify blocks manually
#
# ============================================================================
# NOTES
# ============================================================================
#
# - Template ini adalah INSTRUCTIONS untuk AI, bukan template markdown biasa
# - User tidak akan copy-paste template ini
# - Workflow ini dijalankan oleh AI saat user request "generate konten baru"
# - AI harus autonomous dalam menjalankan Steps 1-6
# - AI harus interactive: present recommendation → get approval → execute
#
# ============================================================================
