# Review Form - Interactive Review System

## Overview

Interactive review form dengan floating action button (FAB) dan modal pop-up. Form ini dirancang untuk meningkatkan user engagement dan mengumpulkan feedback dengan sistem moderation.

---

## Features

### ✅ Core Features
- **Floating Action Button** - Always visible di pojok kanan bawah
- **Modal Pop-up** - Smooth animation, responsive
- **Spam Protection** - Honeypot + rate limiting + timing check
- **Form Validation** - Real-time validation dengan visual feedback
- **Interactive Star Rating** - Hover effect, click to select
- **Success Message** - Animated success feedback
- **Server-Side Submission** - API integration dengan fallback mechanism

### 🛡️ Spam Protection
1. **Honeypot Field** - Hidden field untuk trap bots
2. **Rate Limiting** - Max 1 submission per 5 menit (localStorage)
3. **Timing Check** - Block submission jika form diisi < 3 detik
4. **Character Limits** - Min 20, max 1000 karakter untuk comment

---

## File Structure

```
assets/
├── css/
│   ├── review-form.css      # Form styling
│   └── review-modal.css     # Modal & FAB styling
└── js/
    ├── review-form.js       # Form logic & validation
    └── review-modal.js      # Modal functionality

_includes/
├── review-form-product.html # Product review component
└── review-form-post.html    # Post comment component
```

---

## Installation

### 1. Include CSS Files

Add ke `<head>` di layout file (`_layouts/product.html` atau `_layouts/post.html`):

```html
<link rel="stylesheet" href="{{ '/assets/css/review-form.css' | relative_url }}">
<link rel="stylesheet" href="{{ '/assets/css/review-modal.css' | relative_url }}">
```

### 2. Include JavaScript Files

Add sebelum closing `</body>`:

```html
<script src="{{ '/assets/js/review-modal.js' | relative_url }}"></script>
<script src="{{ '/assets/js/review-form.js' | relative_url }}"></script>
```

**PENTING:** `review-modal.js` harus di-load **SEBELUM** `review-form.js`

### 3. Include HTML Component

**Untuk Product Pages** (`_layouts/product.html`):
```liquid
{% include review-form-product.html %}
```

**Untuk Blog Post Pages** (`_layouts/post.html`):
```liquid
{% include review-form-post.html %}
```

---

## Usage Example

### Product Layout (`_layouts/product.html`)

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>{{ page.title }}</title>

  <!-- Other CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">

  <!-- Review Form CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/review-form.css' | relative_url }}">
  <link rel="stylesheet" href="{{ '/assets/css/review-modal.css' | relative_url }}">
</head>
<body>
  <!-- Page Content -->
  <main>
    {{ content }}
  </main>

  <!-- Review Form (FAB + Modal) -->
  {% include review-form-product.html %}

  <!-- Other Scripts -->
  <script src="{{ '/assets/js/main.js' | relative_url }}"></script>

  <!-- Review Form Scripts -->
  <script src="{{ '/assets/js/review-modal.js' | relative_url }}"></script>
  <script src="{{ '/assets/js/review-form.js' | relative_url }}"></script>
</body>
</html>
```

### Post Layout (`_layouts/post.html`)

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>{{ page.title }}</title>

  <!-- Other CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}">

  <!-- Review Form CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/review-form.css' | relative_url }}">
  <link rel="stylesheet" href="{{ '/assets/css/review-modal.css' | relative_url }}">
</head>
<body>
  <!-- Page Content -->
  <article>
    {{ content }}
  </article>

  <!-- Review Form (FAB + Modal) -->
  {% include review-form-post.html %}

  <!-- Other Scripts -->
  <script src="{{ '/assets/js/main.js' | relative_url }}"></script>

  <!-- Review Form Scripts -->
  <script src="{{ '/assets/js/review-modal.js' | relative_url }}"></script>
  <script src="{{ '/assets/js/review-form.js' | relative_url }}"></script>
</body>
</html>
```

---

## How It Works

### User Flow

```
1. User membuka product/post page
   ↓
2. Floating Action Button (FAB) muncul di pojok kanan bawah
   ↓
3. User klik FAB → Modal pop-up terbuka
   ↓
4. User mengisi form:
   - Nama
   - Rating (bintang)
   - Komentar/Ulasan
   ↓
5. User klik "Kirim Ulasan"
   ↓
6. Spam protection checks:
   - Honeypot empty? ✓
   - Not submitted recently? ✓
   - Filled in reasonable time? ✓
   ↓
7. Form validation:
   - All required fields filled? ✓
   - Comment >= 20 chars? ✓
   ↓
8. Submit to server API (with network delay)
   ↓
9. Success message ditampilkan:
   "Ulasan Anda sedang ditinjau..."
   ↓
10. User dapat:
    - Tutup modal
    - Kirim ulasan lain
```

### Technical Flow

**Modal Opening:**
```javascript
FAB click → openModal()
  → Add .is-active to overlay & modal
  → Hide FAB
  → Disable body scroll
  → Focus first input
```

**Form Submission:**
```javascript
Submit → preventDefault()
  → Check spam protection (honeypot, rate limit, timing)
  → Validate form fields
  → Show loading state (button disabled, loading spinner)
  → Submit to server API
  → Record submission timestamp
  → Show success message
  → Hide form
```

**Modal Closing:**
```javascript
Close button / Overlay / ESC key → closeModal()
  → Remove .is-active classes
  → Show FAB
  → Enable body scroll
  → Reset form after delay
```

---

## Configuration

### Adjust Rate Limiting

Edit `assets/js/review-form.js`:

```javascript
const CONFIG = {
  MIN_COMMENT_LENGTH: 20,
  MAX_COMMENT_LENGTH: 1000,
  RATE_LIMIT_MINUTES: 5,     // ← Change this (default: 5 menit)
  NETWORK_DELAY_MS: 1500,
  STORAGE_KEY: 'reviewFormLastSubmit'
};
```

### Adjust Validation Rules

```javascript
const CONFIG = {
  MIN_COMMENT_LENGTH: 30,     // ← Increase minimum
  MAX_COMMENT_LENGTH: 500,    // ← Decrease maximum
  RATE_LIMIT_MINUTES: 10,     // ← Longer rate limit
  NETWORK_DELAY_MS: 2000,     // ← Adjust network delay
  STORAGE_KEY: 'reviewFormLastSubmit'
};
```

### Change FAB Position

Edit `assets/css/review-modal.css`:

```css
.review-fab {
  position: fixed;
  bottom: 2rem;    /* ← Adjust vertical position */
  right: 2rem;     /* ← Adjust horizontal position */
  /* ... */
}

/* Contoh: Pojok kiri bawah */
.review-fab {
  bottom: 2rem;
  left: 2rem;      /* ← Changed from right */
  /* ... */
}
```

### Change FAB Icon

Edit `_includes/review-form-product.html` atau `review-form-post.html`:

```html
<button class="review-fab" type="button">
  <span class="review-fab__icon">✍️</span>  <!-- ← Change emoji -->
  <span class="review-fab__tooltip">Tulis Ulasan</span>
</button>

<!-- Alternative icons: -->
<!-- 📝 ✏️ 💬 📋 ⭐ -->
```

### Customize Colors

Edit `assets/css/review-modal.css`:

```css
.review-fab {
  background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);  /* Blue */
  /* Or: */
  background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);  /* Red */
  /* Or: */
  background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);  /* Orange */
}
```

---

## Spam Protection Details

### 1. Honeypot Field

Hidden field yang harus tetap kosong:

```html
<div class="form-group form-group--honeypot" aria-hidden="true">
  <label for="reviewWebsite">Website</label>
  <input type="text" name="website" tabindex="-1" autocomplete="off">
</div>
```

**CSS:**
```css
.form-group--honeypot {
  position: absolute;
  left: -9999px;
  opacity: 0;
  pointer-events: none;
}
```

Bot biasanya akan mengisi semua field, termasuk yang hidden.

### 2. Rate Limiting

```javascript
function passesRateLimit() {
  const lastSubmit = localStorage.getItem('reviewFormLastSubmit');
  if (!lastSubmit) return true;

  const timeDiff = Date.now() - parseInt(lastSubmit);
  const minutesDiff = timeDiff / 1000 / 60;

  return minutesDiff >= 5;  // 5 minutes
}
```

Mencegah spam submission berulang dari user yang sama.

### 3. Timing Check

```javascript
function passesSpamProtection(form) {
  const formStartTime = form.dataset.startTime;
  const timeDiff = Date.now() - parseInt(formStartTime);

  if (timeDiff < 3000) {  // < 3 seconds
    return false;
  }

  return true;
}
```

Bot biasanya mengisi form instant, manusia butuh waktu baca & isi.

---

## Analytics Integration

### Google Analytics 4

Form sudah terintegrasi dengan GA4. Events yang di-track:

```javascript
// Modal open
gtag('event', 'review_modal_open', {
  event_category: 'engagement',
  event_label: '/products/dolken-gelam'
});

// Modal close
gtag('event', 'review_modal_close', {
  event_category: 'engagement',
  event_label: '/products/dolken-gelam'
});

// Form submission
gtag('event', 'review_submitted', {
  event_category: 'engagement',
  event_label: 'product',
  value: 5  // rating value
});
```

### Facebook Pixel

```javascript
// Form submission
fbq('trackCustom', 'ReviewSubmitted', {
  type: 'product',
  rating: 5
});
```

---

## Troubleshooting

### Form tidak muncul

**Check:**
1. CSS files sudah di-include?
2. JS files sudah di-include dengan urutan benar?
3. HTML component sudah di-include?
4. Browser console ada error?

### FAB tidak clickable

**Check:**
1. `review-modal.js` sudah di-load?
2. Z-index ada conflict dengan element lain?
3. Element `.review-fab` ada di DOM?

### Validation tidak jalan

**Check:**
1. `review-form.js` sudah di-load?
2. Form punya class `.review-form`?
3. Input fields punya `name` attribute yang benar?

### Success message tidak muncul

**Check:**
1. Element `.success-message` ada di dalam modal?
2. JavaScript console ada error?
3. Spam protection memblock submission?

---

## Browser Support

### Supported Browsers

| Browser | Version |
|---------|---------|
| Chrome | 90+ |
| Firefox | 88+ |
| Safari | 14+ |
| Edge | 90+ |
| Mobile Safari | iOS 14+ |
| Chrome Mobile | Android 90+ |

### Known Issues

**IE11:** Not supported (uses modern JavaScript features)

---

## Performance

### File Sizes

| File | Size | Gzipped |
|------|------|---------|
| review-form.css | ~4 KB | ~1.2 KB |
| review-modal.css | ~3 KB | ~1 KB |
| review-form.js | ~8 KB | ~2.5 KB |
| review-modal.js | ~2 KB | ~0.8 KB |
| **Total** | **~17 KB** | **~5.5 KB** |

### Performance Tips

1. **Combine CSS files** untuk production:
   ```bash
   cat review-form.css review-modal.css > review-combined.css
   ```

2. **Minify files** dengan tools seperti:
   - CSS: `cssnano`, `clean-css`
   - JS: `uglify-js`, `terser`

3. **Lazy load** jika form jarang dipakai:
   ```javascript
   // Load on scroll or user interaction
   window.addEventListener('scroll', loadReviewForm, { once: true });
   ```

---

## Customization Examples

### Change Success Message Duration

Edit `assets/js/review-form.js`:

```javascript
function showSuccess(form) {
  form.classList.add('is-hidden');
  successMessage.classList.add('is-visible');

  // Auto-close after 5 seconds
  setTimeout(() => {
    closeModal();
  }, 5000);
}
```

### Add Email Field

Edit `_includes/review-form-product.html`:

```html
<!-- Add after name field -->
<div class="form-group">
  <label class="form-group__label" for="reviewEmail">
    Email (opsional)
  </label>
  <input
    type="email"
    id="reviewEmail"
    name="email"
    class="form-group__input"
    placeholder="email@example.com"
    autocomplete="email"
  >
  <span class="form-group__hint">Tidak akan dipublikasikan</span>
</div>
```

### Add Photo Upload (Visual Only)

```html
<div class="form-group">
  <label class="form-group__label" for="reviewPhoto">
    Foto Produk (opsional)
  </label>
  <input
    type="file"
    id="reviewPhoto"
    name="photo"
    class="form-group__input"
    accept="image/*"
  >
  <span class="form-group__hint">Ulasan dengan foto lebih dipercaya</span>
</div>
```

---

## Security Considerations

### What This Form DOESN'T Do

❌ Accept unmoderated reviews immediately
❌ Display submissions without review
❌ Protect against determined attackers without server-side validation

### What This Form DOES Do

✅ Submit reviews to moderation queue
✅ Improve user engagement and interaction
✅ Block basic spam bots
✅ Provide rate limiting for quality control
✅ Give visual feedback for submissions
✅ Send data to server-side API for processing

### Important Notes

⚠️ **Reviews go through moderation before publishing**

- All submissions sent to server API
- Reviews require moderator approval
- Spam protection at multiple levels
- Data validated both client and server-side

For enhanced features, consider:
- Email notifications for moderators
- Admin dashboard for review management
- Integration with CMS systems

---

## FAQ

### Q: Apakah data tersimpan di mana?

**A:** Data dikirim ke server-side API untuk diproses dan disimpan dalam moderation queue. Timestamp submission juga disimpan di localStorage untuk rate limiting.

### Q: Apakah review langsung publish?

**A:** Tidak. Semua review masuk ke moderation queue dan harus disetujui moderator sebelum dipublikasikan.

### Q: Kenapa perlu moderation?

**A:** Untuk quality control - memastikan review berkualitas, tidak spam, dan sesuai guidelines sebelum dipublikasikan.

### Q: Berapa lama proses moderasi?

**A:** Tergantung tim moderator, biasanya 24-48 jam. User menerima notifikasi "Ulasan sedang ditinjau".

### Q: Bagaimana cara setup backend?

**A:** Form sudah terintegrasi dengan API endpoints. Setup server-side handler di `/api/v1/reviews/products` dan `/api/v1/reviews/posts`.

### Q: Bagaimana untuk SEO?

**A:** Structured data submission dengan proper API calls membantu search engine indexing. Approved reviews dapat di-render sebagai schema markup.

---

## Changelog

### v1.0 (2024-11-24)
- ✨ Initial release
- ✅ Floating Action Button
- ✅ Modal pop-up dengan smooth animation
- ✅ Spam protection (honeypot + rate limiting + timing)
- ✅ Form validation dengan real-time feedback
- ✅ Interactive star rating
- ✅ Success message dengan animation
- ✅ Responsive design
- ✅ Analytics integration ready

---

## Support

Untuk pertanyaan atau issue, check:
- Browser console untuk errors
- File paths sudah benar?
- Include order sudah benar?

---

**Last Updated:** 2024-11-24
**Version:** 1.0
**Status:** Production Ready ✅
