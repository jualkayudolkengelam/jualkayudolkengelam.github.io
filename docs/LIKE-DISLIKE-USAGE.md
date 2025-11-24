# Like/Dislike Buttons - Documentation

Sistem tombol Like/Dislike floating yang ditempatkan di atas review FAB button.

## 📁 File Structure

```
assets/
├── css/
│   └── like-dislike.css          # Styling untuk tombol Like/Dislike
└── js/
    └── like-dislike.js            # Functionality Like/Dislike

_includes/
└── like-dislike-buttons.html      # HTML template tombol
```

## 🎯 Features

1. **Like & Dislike Buttons**
   - Floating buttons di atas review FAB
   - Toggle functionality (bisa dibatalkan)
   - Visual feedback dengan warna berbeda

2. **Animasi**
   - Pulse animation saat hover
   - Scale animation saat diklik
   - Floating emoji animation
   - Ripple effect
   - Smooth transitions

3. **Notifikasi Toast**
   - Muncul di tengah bawah layar
   - Auto-hide setelah 2.5 detik
   - Berbagai jenis: success, info, neutral

4. **Local Storage**
   - Menyimpan preferensi user per halaman
   - Persistent state saat reload
   - Unique key per page URL

5. **Spam Protection**
   - Cooldown 1 detik antar klik
   - Mencegah spam clicking

6. **Analytics Integration**
   - Google Analytics 4 tracking
   - Facebook Pixel tracking
   - Console logging untuk debugging

## 🚀 Installation

### 1. Include CSS di `<head>`

```html
<!-- In _includes/head.html or your main layout -->
<link rel="stylesheet" href="{{ '/assets/css/like-dislike.css' | relative_url }}">
```

### 2. Include HTML di layout

```html
<!-- In your main layout (e.g., _layouts/default.html) -->
<!-- Place before closing </body> tag -->
{% include like-dislike-buttons.html %}
```

### 3. Include JavaScript

```html
<!-- In your main layout, before closing </body> tag -->
<script src="{{ '/assets/js/like-dislike.js' | relative_url }}"></script>
```

## 💡 Usage Example

### Lengkap di Layout

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>{{ page.title }}</title>

  <!-- CSS -->
  <link rel="stylesheet" href="{{ '/assets/css/like-dislike.css' | relative_url }}">
</head>
<body>

  <!-- Your content here -->
  {{ content }}

  <!-- Like/Dislike Buttons -->
  {% include like-dislike-buttons.html %}

  <!-- JavaScript -->
  <script src="{{ '/assets/js/like-dislike.js' | relative_url }}"></script>
</body>
</html>
```

## 🎨 Customization

### Mengubah Posisi Buttons

Edit di `like-dislike.css`:

```css
.like-dislike-buttons {
  bottom: 8rem;  /* Ubah ini untuk posisi vertikal */
  right: 2rem;   /* Ubah ini untuk posisi horizontal */
}
```

### Mengubah Warna Buttons

```css
/* Like button active state */
.like-dislike-buttons__like.is-active {
  background: linear-gradient(135deg, #YOUR_COLOR_1 0%, #YOUR_COLOR_2 100%);
}

/* Dislike button active state */
.like-dislike-buttons__dislike.is-active {
  background: linear-gradient(135deg, #YOUR_COLOR_1 0%, #YOUR_COLOR_2 100%);
}
```

### Mengubah Icon

Edit di `_includes/like-dislike-buttons.html`:

```html
<!-- Ganti emoji atau gunakan icon font -->
<span class="like-dislike-buttons__icon">❤️</span>  <!-- Love -->
<span class="like-dislike-buttons__icon">💔</span>  <!-- Broken heart -->

<!-- Atau gunakan Font Awesome -->
<span class="like-dislike-buttons__icon"><i class="fas fa-heart"></i></span>
```

### Mengubah Durasi Notifikasi

Edit di `like-dislike.js`:

```javascript
const CONFIG = {
  NOTIFICATION_DURATION: 2500,  // milliseconds (ubah ini)
  COOLDOWN_MS: 1000             // cooldown antar klik
};
```

## 📊 Analytics Events

### Google Analytics 4

```javascript
gtag('event', 'like_dislike_interaction', {
  event_category: 'engagement',
  event_label: 'like' | 'dislike',
  previous_state: 'none' | 'like' | 'dislike',
  page_path: '/current-page-path'
});
```

### Facebook Pixel

```javascript
fbq('trackCustom', 'LikeDislikeClick', {
  action: 'like' | 'dislike',
  page: '/current-page-path'
});
```

## 🔧 Configuration Options

Di `like-dislike.js`, ubah `CONFIG` object:

```javascript
const CONFIG = {
  STORAGE_KEY_PREFIX: 'likeDislike_',     // Prefix untuk localStorage
  ANIMATION_DURATION: 300,                 // Durasi animasi button (ms)
  NOTIFICATION_DURATION: 2500,             // Durasi notifikasi (ms)
  COOLDOWN_MS: 1000                        // Cooldown antar klik (ms)
};
```

## 🎭 State Management

### States

1. **Default** - Tidak ada preferensi
2. **Like Active** - User menyukai konten
3. **Dislike Active** - User tidak menyukai konten

### State Transitions

```
Default → Like     : Klik Like button
Default → Dislike  : Klik Dislike button
Like → Default     : Klik Like button lagi (toggle off)
Like → Dislike     : Klik Dislike button (switch)
Dislike → Default  : Klik Dislike button lagi (toggle off)
Dislike → Like     : Klik Like button (switch)
```

## 📱 Responsive Design

- **Desktop** (> 768px): Buttons 56px, full features
- **Tablet** (≤ 768px): Buttons 52px, no tooltips
- **Mobile** (≤ 480px): Buttons 48px, compact spacing

## 🐛 Debugging

Check console logs:

```javascript
// Initialization
console.log('[Like/Dislike] Initialized');

// Interactions
console.log('[Like/Dislike] Interaction:', {
  action: 'like',
  previousState: 'none',
  page: '/current-page'
});
```

## ⚠️ Catatan Penting

1. **LocalStorage** - Data disimpan per browser/device
2. **Unique Key** - Setiap halaman memiliki state terpisah
3. **Z-index** - Buttons (1002) > Review FAB (1001) > WhatsApp (1000)
4. **No Backend** - Ini adalah pure frontend interaction
5. **Social Proof** - Tidak menampilkan counter total likes

## 🔄 Integration dengan Review FAB

Like/Dislike buttons otomatis positioned di atas Review FAB:

```
┌─────────────────┐
│                 │
│   👍 Like       │  ← Like/Dislike Buttons (z-index: 1002)
│   👎 Dislike    │
│                 │
│   ⭐ Review     │  ← Review FAB (z-index: 1001)
│                 │
│   💬 WhatsApp   │  ← WhatsApp Button (z-index: 1000)
│                 │
└─────────────────┘
```

## 🎨 CSS Classes Reference

### Container
- `.like-dislike-buttons` - Main container

### Buttons
- `.like-dislike-buttons__button` - Base button
- `.like-dislike-buttons__like` - Like button
- `.like-dislike-buttons__dislike` - Dislike button
- `.is-active` - Active state modifier
- `.is-animating` - Animation state modifier

### Notification
- `.like-dislike-notification` - Toast notification
- `.like-dislike-notification--success` - Success variant
- `.like-dislike-notification--info` - Info variant
- `.like-dislike-notification--neutral` - Neutral variant
- `.is-visible` - Visible state

### Animation
- `.like-dislike-float-icon` - Floating emoji

## 📝 Example Scenarios

### Scenario 1: User menyukai konten
1. User klik Like button 👍
2. Button berubah biru dan active
3. Animasi floating emoji muncul
4. Toast "Terima kasih atas Like-nya! 👍" muncul
5. State disimpan di localStorage

### Scenario 2: User switch dari Like ke Dislike
1. User sudah like (button biru active)
2. User klik Dislike button 👎
3. Like button kembali default
4. Dislike button berubah orange dan active
5. Toast "Terima kasih atas feedback-nya" muncul
6. State updated di localStorage

### Scenario 3: User batalkan Like
1. User sudah like (button biru active)
2. User klik Like button lagi
3. Button kembali ke default state (gray)
4. Toast "Like dibatalkan" muncul
5. State dihapus dari localStorage

## 🚀 Future Enhancements

Possible improvements:
- [ ] Backend integration untuk count total likes
- [ ] Display total likes/dislikes counter
- [ ] User authentication integration
- [ ] Share functionality
- [ ] Report/Flag button
- [ ] Animated reactions (like Facebook)
- [ ] Custom emoji picker

## 📞 Support

Jika ada masalah atau pertanyaan, check:
1. Console logs untuk error messages
2. Browser localStorage (DevTools → Application → Local Storage)
3. CSS conflicts dengan existing styles
4. JavaScript conflicts dengan existing scripts

---

**Version:** 1.0.0
**Last Updated:** 2025-11-25
**Compatibility:** Modern browsers (Chrome, Firefox, Safari, Edge)
