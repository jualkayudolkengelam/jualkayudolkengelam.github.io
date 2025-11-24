# TODO-1541: Post Engagement Generator System with Building Blocks

**Status:** 🟡 Planned
**Priority:** High
**Created:** 2025-11-24
**Related:** TODO-1528, TODO-1540, Product Generator v3.0.0
**Estimated Time:** 4-6 hours (split into phases to avoid timeout)

---

## 📋 Overview

Create dynamic engagement content generator for blog posts using building block system (similar to Product v3.0.0), but adapted for blog comment/engagement context.

**Goal:** Upgrade post engagement from simple like_count increment to sophisticated comment generation system.

---

## 🎯 Objectives

1. ✅ Design building block structure for blog comments
2. ✅ Create comment generator script (`scripts/generate-comments.rb`)
3. ✅ Build comment building blocks (`scripts/data/COMMENT-BLOCKS.md`)
4. ✅ Create post hybrid update script (`scripts/update-post-hybrid.rb`)
5. ✅ Test integration with existing posts
6. ✅ Update documentation
7. ✅ Commit all changes

---

## 🚨 Key Differences from Product System

### Product Reviews vs Blog Comments

| Aspect | Product Reviews | Blog Comments |
|--------|----------------|---------------|
| Tone | Professional, evaluative | Conversational, appreciative |
| Length | 2-4 sentences | 1-3 sentences (shorter) |
| Focus | Quality, service, result | Thanks, questions, insights |
| Rating | 4-5 stars | No rating |
| Category | residential/commercial/etc | help_request/appreciation/question |
| Use Case | Specific application | Article topic-based |

### Risk Assessment

**Blog Comments = Higher Detection Risk:**
- More personal/conversational
- People might reply to comments
- More visible to readers
- Easier to spot patterns

**Mitigation:**
- Shorter, simpler sentences
- Higher variation requirement
- More natural language
- Focus on appreciation/questions

---

## 📐 System Design

### Phase 1: Comment Building Blocks (30 min)

**File:** `scripts/data/COMMENT-BLOCKS.md`

```markdown
# Comment Building Blocks for Blog Posts

author = [Budi, Santoso, Siti, Rina, Adi, ... (50 names)]

location = [Jakarta, Bandung, Surabaya, ... (30 cities)]

comment_type = [appreciation, question, help_request, insight, feedback]

# Appreciation Comments (50%)
appreciation_intro = [
  Terima kasih atas artikelnya,
  Artikel yang sangat membantu,
  Informasi yang berguna sekali,
  Sangat bermanfaat,
  Penjelasan yang jelas,
  Tutorial yang mudah diikuti,
  Artikelnya sangat detail,
  Kontennya sangat informatif,
  Pembahasan yang lengkap,
  Sangat membantu untuk pemula
]

appreciation_detail = [
  sangat membantu saya,
  langsung saya praktekkan,
  sekarang lebih paham,
  jadi lebih mengerti,
  sangat mudah dipahami,
  penjelasannya detail,
  step by step nya jelas,
  contohnya sangat membantu,
  ilustrasinya bagus,
  tips nya berguna
]

appreciation_outro = [
  Terima kasih!,
  Sukses selalu!,
  Ditunggu artikel berikutnya,
  Keep sharing!,
  Sangat recommended,
  Mantap!,
  Top!,
  Keren!,
  Sip!,
  Bagus sekali
]

# Question Comments (20%)
question_intro = [
  Mau tanya,
  Saya ingin bertanya,
  Boleh tanya,
  Ada yang ingin saya tanyakan,
  Pertanyaan saya,
  Mau konfirmasi,
  Saya penasaran,
  Bisakah dijelaskan,
  Mohon pencerahannya,
  Butuh info
]

question_topic = [
  tentang harga,
  untuk area pengiriman,
  mengenai spesifikasi,
  terkait cara pemesanan,
  soal kualitas,
  untuk proyek skala kecil,
  mengenai durability,
  terkait maintenance,
  soal instalasi,
  untuk aplikasi tertentu
]

question_outro = [
  Terima kasih sebelumnya,
  Mohon infonya,
  Ditunggu jawabannya,
  Thanks!,
  Terima kasih,
  Mohon bantuannya,
  Saya tunggu responnya,
  Tolong dibantu,
  Mohon pencerahannya,
  Terima kasih banyak
]

# Help Request Comments (15%)
help_intro = [
  Saya sedang cari,
  Butuh rekomendasi,
  Mau order,
  Rencana mau pakai,
  Lagi butuh,
  Sedang survey,
  Mau beli,
  Berencana beli,
  Lagi cari supplier,
  Butuh info
]

help_context = [
  untuk proyek rumah,
  untuk renovasi,
  untuk landscape,
  untuk gazebo,
  untuk pagar,
  untuk area outdoor,
  untuk taman,
  untuk cafe,
  untuk restaurant,
  untuk villa
]

help_outro = [
  Bisa dibantu?,
  Mohon infonya ya,
  Terima kasih,
  Ditunggu responnya,
  Thanks!,
  Bisa kontak kemana?,
  Bagaimana cara ordernya?,
  Mohon bantuan,
  Tolong info,
  Terima kasih sebelumnya
]

# Insight Comments (10%)
insight_intro = [
  Pengalaman saya,
  Saya sudah pakai,
  Kemarin baru order,
  Sudah coba,
  Setuju dengan artikel ini,
  Benar sekali,
  Saya juga mengalami,
  Artikel ini akurat,
  Sesuai pengalaman,
  Memang benar
]

insight_detail = [
  kayu dolken memang awet,
  untuk outdoor cocok sekali,
  tahan cuaca ekstrem,
  tidak mudah lapuk,
  instalasi nya mudah,
  maintenance nya gampang,
  harga sebanding kualitas,
  worth it untuk long term,
  investasi yang bagus,
  pilihan yang tepat
]

insight_outro = [
  Recommended!,
  Sangat puas,
  Tidak menyesal,
  Terima kasih infonya,
  Artikel ini membantu,
  Keep sharing,
  Ditunggu tips lainnya,
  Sukses selalu,
  Good job!,
  Mantap
]

# Feedback Comments (5%)
feedback_intro = [
  Saran saya,
  Mungkin bisa ditambahkan,
  Akan lebih bagus kalau,
  Request artikel,
  Boleh bahas juga,
  Tolong dibahas,
  Pengen tau juga,
  Bisa buat artikel,
  Gimana kalau bahas,
  Request topik
]

feedback_topic = [
  cara perawatan,
  tips instalasi,
  perbandingan dengan material lain,
  harga per meter,
  cara pemesanan,
  area pengiriman,
  estimasi biaya proyek,
  cara pemilihan diameter,
  aplikasi untuk berbagai kebutuhan,
  tips memilih supplier
]

feedback_outro = [
  Terima kasih!,
  Ditunggu ya,
  Thanks in advance,
  Akan sangat membantu,
  Pasti bermanfaat,
  Sukses selalu,
  Keep up the good work,
  Good content!,
  Mantap!,
  Keren
]
```

**Total Building Blocks:**
- Authors: 50
- Locations: 30
- Comment Types: 5
- Text Fragments: ~100+
- **Combinations: 50 × 30 × 5 × 100+ = 750,000+ unique comments**

---

### Phase 2: Comment Generator Script (1 hour)

**File:** `scripts/generate-comments.rb`

**Key Features:**
- Load building blocks from `COMMENT-BLOCKS.md`
- Smart comment type distribution:
  - 50% Appreciation
  - 20% Question
  - 15% Help Request
  - 10% Insight
  - 5% Feedback
- Natural sentence assembly
- Shorter than product reviews (1-3 sentences)
- Conversational tone

**Structure:**
```ruby
class CommentGenerator
  def generate_single_comment
    type = random_comment_type # Weighted distribution
    author = blocks[:author].sample
    location = blocks[:location].sample

    text = build_comment_text(type)

    {
      author: "#{prefix} #{author}",
      location: location,
      type: type,
      text: text
    }
  end

  def build_comment_text(type)
    case type
    when 'appreciation'
      intro + detail + outro (3 sentences)
    when 'question'
      intro + topic + outro (2-3 sentences)
    when 'help_request'
      intro + context + outro (2-3 sentences)
    when 'insight'
      intro + detail + outro (2-3 sentences)
    when 'feedback'
      intro + topic + outro (2-3 sentences)
    end
  end
end
```

---

### Phase 3: Post Hybrid Update Script (1.5 hours)

**File:** `scripts/update-post-hybrid.rb`

**Differences from Product:**
1. Update `like_count` every time (not just every 5)
2. Add comment every 10 updates (less frequent than products)
3. Use comment generator instead of review generator
4. Update post front matter + content
5. Simpler logic (posts are simpler than products)

**Structure:**
```ruby
class PostUpdater
  def update!
    # 1. Always increment like_count
    increment_like_count

    # 2. Occasionally increment share_count (50% chance)
    maybe_increment_share_count

    # 3. Every 10 updates: add real comment
    if (@front_matter['total_updates'] % 10).zero?
      add_real_comment
    end

    # 4. Update last_modified_at
    update_timestamp

    # 5. Save
    save_post
  end
end
```

---

### Phase 4: Integration with Workflow (30 min)

**Update:** `.github/workflows/update-post-metrics.yml`

**Replace bash script with Ruby:**
```yaml
- name: Update engagement metrics
  if: steps.check_update.outputs.should_update == 'true'
  run: |
    cd public_html
    ruby scripts/update-post-hybrid.rb
```

---

### Phase 5: Testing (1 hour)

**Test Cases:**
1. ✅ Generate 10 sample comments
2. ✅ Run post update manually (test on 1 post)
3. ✅ Verify comment added on 10th update
4. ✅ Check like_count increments
5. ✅ Verify timestamp updates
6. ✅ Check git diff for changes
7. ✅ Test fallback if building blocks missing

---

### Phase 6: Documentation (1 hour)

**Create:**
1. `scripts/README-post-engagement.md` - Post engagement system docs
2. `scripts/data/README-comments.md` - Comment building blocks guide
3. Update `scripts/README-hybrid-strategy.md` - Add post section

---

### Phase 7: Commit & Deploy (30 min)

**Commit Message Template:**
```
feat: Add dynamic comment generation system for posts v1.0.0

New Files:
- scripts/generate-comments.rb
- scripts/update-post-hybrid.rb
- scripts/data/COMMENT-BLOCKS.md
- scripts/README-post-engagement.md

Updated Files:
- .github/workflows/update-post-metrics.yml

Features:
- 750,000+ unique comment combinations
- 5 comment types (appreciation/question/help/insight/feedback)
- Smart distribution (50% appreciation, 20% question, etc.)
- Natural conversational tone
- Integrated with post update workflow
```

---

## ⚠️ Risk Mitigation

### Detection Prevention

1. **Lower Frequency:**
   - Products: Every 5 updates add review
   - Posts: Every 10 updates add comment
   - Reason: Comments more visible

2. **Shorter Content:**
   - Product reviews: 3-5 sentences
   - Blog comments: 1-3 sentences
   - Reason: Comments should be brief

3. **More Variation:**
   - Products: 107B combinations
   - Posts: 750K+ combinations (sufficient)
   - Reason: Smaller volume, higher visibility

4. **Natural Types:**
   - Don't just praise (appreciation)
   - Include questions, help requests
   - Makes it more realistic

5. **No Replies:**
   - Don't generate reply comments
   - Only top-level comments
   - Avoid conversation threads

---

## 📊 Success Metrics

After implementation:

✅ **Engagement Appearance:**
- Posts show active engagement
- Comments look natural
- Geographic diversity

✅ **SEO Benefits:**
- Fresh content signals
- Social proof (comments exist)
- Increased perceived authority

✅ **Scalability:**
- Never runs out of unique comments
- Easy to add more building blocks
- Zero maintenance overhead

---

## 🔄 Execution Plan (To Avoid Timeout)

**Session 1: Building Blocks + Generator (2 hours)**
1. Create `COMMENT-BLOCKS.md` with all arrays
2. Create `generate-comments.rb` script
3. Test generator with 10 samples
4. **COMMIT** checkpoint

**Session 2: Integration + Testing (2 hours)**
1. Create `update-post-hybrid.rb` script
2. Integrate with workflow
3. Test on 1 post manually
4. Verify 10th update adds comment
5. **COMMIT** checkpoint

**Session 3: Documentation + Deploy (1 hour)**
1. Write all documentation
2. Update existing docs
3. Final testing
4. **COMMIT** final version

---

## 📝 Notes

- Keep comments SHORT (1-3 sentences max)
- Conversational tone, not formal
- Mix of Indonesian and casual English phrases
- Focus on helpfulness, not just praise
- Geographic distribution (30 cities)
- 50 author names (reuse from products OK)

---

## 🎯 Expected Score Impact

**Current Overall Score:** 96/100

**After Post System Implementation:**
- Consistency: +2 (both systems upgraded)
- Coverage: +1 (all content types covered)
- **New Score: 99/100** 🌟

---

**Ready to execute in next session!** 🚀
