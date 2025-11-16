# TODO-1531: Performance Optimization Plan

**Status:** Pending
**Priority:** High
**Created:** 2025-11-16
**Target:** Meningkatkan Lighthouse Performance Score dari 49 → 90+

---

## Context

Berdasarkan Lighthouse audit untuk halaman blog post (post-with-products layout):
- **Current Performance Score:** 49 (Poor)
- **First Contentful Paint (FCP):** 3.1s (Target: <1.8s)
- **Largest Contentful Paint (LCP):** 5.1s (Target: <2.5s)
- **Total Blocking Time (TBL):** 960ms (Target: <200ms)
- **Cumulative Layout Shift (CLS):** 0.136 (Target: <0.1)

**Already Done (Commit: effae5d):**
- ✅ Preconnect & DNS prefetch untuk cdn.jsdelivr.net
- ✅ fetchpriority="high" untuk critical CSS
- ✅ Defer loading Bootstrap Icons
- ✅ Preload LCP image
- ✅ Explicit image dimensions untuk prevent CLS

---

## Plan 1: Service Worker & PWA Implementation

### Objective
Implement Progressive Web App dengan Service Worker untuk aggressive caching dan offline support.

### Benefits
- ✅ Instant loading untuk repeat visitors
- ✅ Offline support
- ✅ Cache HTML, CSS, JS, images di browser
- ✅ Reduce server load

### Implementation Steps

1. **Create Service Worker file** (`sw.js`)
```javascript
const CACHE_NAME = 'kayu-dolken-v1';
const urlsToCache = [
  '/',
  '/assets/css/main.css',
  '/assets/images/jual-kayu-dolken-gelam-lokalbisnis-001.webp',
  '/assets/images/jual-kayu-dolken-gelam-lokalbisnis-002.webp',
  '/assets/images/jual-kayu-dolken-gelam-lokalbisnis-003.webp',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
  'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'
];

// Install event
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('Opened cache');
        return cache.addAll(urlsToCache);
      })
  );
});

// Fetch event - Network First, fallback to Cache
self.addEventListener('fetch', event => {
  event.respondWith(
    fetch(event.request)
      .then(response => {
        // Clone response
        const responseToCache = response.clone();

        caches.open(CACHE_NAME)
          .then(cache => {
            cache.put(event.request, responseToCache);
          });

        return response;
      })
      .catch(() => {
        return caches.match(event.request);
      })
  );
});

// Activate event - Clean old caches
self.addEventListener('activate', event => {
  const cacheWhitelist = [CACHE_NAME];
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheWhitelist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
```

2. **Register Service Worker** in `_includes/footer.html` or `_layouts/default.html`:
```html
<script>
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/sw.js')
      .then(function(registration) {
        console.log('SW registered: ', registration);
      })
      .catch(function(error) {
        console.log('SW registration failed: ', error);
      });
  });
}
</script>
```

3. **Add manifest.json** for PWA:
```json
{
  "name": "Jual Kayu Dolken Gelam",
  "short_name": "Kayu Dolken",
  "description": "Supplier kayu dolken gelam terpercaya dengan harga terbaik",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#8B4513",
  "icons": [
    {
      "src": "/assets/images/favicon-180.png",
      "sizes": "180x180",
      "type": "image/png"
    },
    {
      "src": "/assets/images/favicon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

4. **Link manifest in head.html**:
```html
<link rel="manifest" href="/manifest.json">
```

### Testing
- Test dengan Lighthouse PWA audit
- Test offline functionality
- Test cache invalidation saat deploy

---

## Plan 2: Asset Versioning & Cache Busting

### Objective
Implement versioning untuk CSS/JS agar browser cache bisa di-invalidate saat ada update.

### Implementation Steps

1. **Manual versioning** in `_config.yml`:
```yaml
version: 1.0.3
```

2. **Update references** in `_includes/head.html`:
```liquid
<link rel="stylesheet" href="{{ '/assets/css/main.css' | relative_url }}?v={{ site.version }}">
```

3. **Alternative: Jekyll Asset Hash plugin** (auto-generate hash):
```ruby
# Gemfile
gem 'jekyll-asset-hash'
```

```liquid
{{ '/assets/css/main.css' | asset_hash }}
```

Output: `/assets/css/main-abc123def.css`

---

## Plan 3: Jekyll Cache Plugin for Schema Generation

### Objective
Cache expensive Liquid operations, terutama schema.org generation yang loop products.

### Implementation Steps

1. **Install plugin**:
```ruby
# Gemfile
gem 'jekyll-cache'
```

2. **Wrap expensive operations** in `_includes/head.html`:

Before:
```liquid
{% if page.layout == 'product' %}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  ...
  "hasOfferCatalog": {
    "itemListElement": [
      {% assign sorted_products = site.products | sort: "price" %}
      {% for product in sorted_products %}
      ...
      {% endfor %}
    ]
  }
}
</script>
{% endif %}
```

After:
```liquid
{% if page.layout == 'product' %}
{% cache product_schema %}
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  ...
  "hasOfferCatalog": {
    "itemListElement": [
      {% assign sorted_products = site.products | sort: "price" %}
      {% for product in sorted_products %}
      ...
      {% endfor %}
    ]
  }
}
</script>
{% endcache %}
{% endif %}
```

3. **Test build time improvement**:
```bash
time bundle exec jekyll build
```

---

## Plan 4: Lazy Load Bootstrap JS

### Objective
Defer/async load Bootstrap JS untuk reduce Total Blocking Time.

### Implementation Steps

1. **Change Bootstrap JS loading** in `_layouts/default.html`:

Before:
```html
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
```

After:
```html
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
```

Or async:
```html
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" async></script>
```

2. **Load only when needed** (conditional):
```liquid
{% if page.layout == 'post-with-products' or page.url == '/' %}
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>
{% endif %}
```

---

## Plan 5: Responsive Image with jekyll-picture-tag

### Objective
Auto-generate multiple image sizes (320px, 640px, 1024px) + WebP untuk responsive loading.

### Benefits
- ✅ Mobile devices load smaller images
- ✅ Auto WebP conversion
- ✅ Better LCP score

### Implementation Steps

1. **Install plugin**:
```ruby
# Gemfile
gem 'jekyll-picture-tag'
```

```yaml
# _config.yml
plugins:
  - jekyll-picture-tag

picture:
  source: "assets/images"
  output: "assets/images/generated"
  markup: "picture"
  presets:
    default:
      formats: [webp, jpeg]
      widths: [320, 640, 1024, 1920]
      sizes:
        mobile: 100vw
        tablet: 50vw
        desktop: 33vw
      fallback_width: 1024
      fallback_format: jpeg

    product:
      formats: [webp, jpeg]
      widths: [320, 640, 1024]
      sizes:
        mobile: 100vw
        desktop: 400px
      fallback_width: 640

    hero:
      formats: [webp, jpeg]
      widths: [640, 1024, 1920]
      sizes:
        mobile: 100vw
        desktop: 100vw
      fallback_width: 1920
```

2. **Update product images** in `_includes/related-products-by-*.html`:

Before:
```html
<picture>
  <source srcset="{{ product.image | replace: '.jpeg', '.webp' | relative_url }}" type="image/webp">
  <img src="{{ product.image | relative_url }}"
       class="card-img-top"
       alt="{{ product.title }}"
       loading="lazy">
</picture>
```

After:
```liquid
{% picture product {{ product.image }} --alt {{ product.title }} %}
```

3. **Update post featured images** in `_layouts/post-with-products.html`:

Before:
```html
<picture>
  <source srcset="{{ page.image | replace: '.jpeg', '.webp' | relative_url }}" type="image/webp">
  <img src="{{ page.image | relative_url }}" ...>
</picture>
```

After:
```liquid
{% picture hero {{ page.image }} --alt {{ page.title }} %}
```

4. **Update carousel images**:
```liquid
{% for image in page.images %}
<div class="carousel-item {% if forloop.first %}active{% endif %}">
  {% picture hero {{ image }} --alt "{{ page.title }} - Foto {{ forloop.index }}" %}
</div>
{% endfor %}
```

### Expected Output
Plugin akan generate:
```
assets/images/generated/
  jual-kayu-dolken-gelam-lokalbisnis-001-320.jpeg
  jual-kayu-dolken-gelam-lokalbisnis-001-320.webp
  jual-kayu-dolken-gelam-lokalbisnis-001-640.jpeg
  jual-kayu-dolken-gelam-lokalbisnis-001-640.webp
  jual-kayu-dolken-gelam-lokalbisnis-001-1024.jpeg
  jual-kayu-dolken-gelam-lokalbisnis-001-1024.webp
  ...
```

HTML output:
```html
<picture>
  <source srcset="...-320.webp 320w, ...-640.webp 640w, ...-1024.webp 1024w" type="image/webp">
  <source srcset="...-320.jpeg 320w, ...-640.jpeg 640w, ...-1024.jpeg 1024w" type="image/jpeg">
  <img src="...-1024.jpeg" alt="...">
</picture>
```

### Important Notes
- First build akan lama (generate semua variants)
- Subsequent builds lebih cepat (hanya process images baru)
- Add `assets/images/generated/` ke `.gitignore` atau commit semuanya
- Ukuran repo akan bertambah jika commit generated images

---

## Plan 6: Critical CSS Inlining (Advanced)

### Objective
Inline critical CSS di `<head>` untuk eliminate render-blocking CSS.

### Tools
- [Critical](https://github.com/addyosmani/critical) - Extract & inline critical CSS
- [Jekyll Critical CSS](https://github.com/rbuchberger/jekyll_critical_css)

### Implementation (if needed)
```ruby
# Gemfile
gem 'jekyll_critical_css'
```

---

## Plan 7: Font Optimization (if using custom fonts)

### Current Status
Site menggunakan system fonts (melalui Bootstrap).

### If adding custom fonts later:
- Use `font-display: swap`
- Preload critical font files
- Subset fonts untuk reduce file size

---

## Execution Order

Recommended implementation sequence:

1. **Phase 1 (Quick Wins):**
   - ✅ Already done: Preconnect, fetchpriority, defer icons, preload LCP
   - [ ] Asset versioning (Plan 2) - 30 mins
   - [ ] Lazy load Bootstrap JS (Plan 4) - 15 mins

2. **Phase 2 (Medium Effort):**
   - [ ] Jekyll Cache plugin (Plan 3) - 1 hour
   - [ ] Service Worker & PWA (Plan 1) - 2-3 hours

3. **Phase 3 (High Effort, High Impact):**
   - [ ] jekyll-picture-tag (Plan 5) - 3-4 hours (termasuk first build)

4. **Phase 4 (Advanced, if needed):**
   - [ ] Critical CSS inlining (Plan 6)

---

## Success Metrics

**Target Performance Score:** 90+

**Expected improvements:**
- FCP: 3.1s → <1.5s
- LCP: 5.1s → <2.0s
- TBL: 960ms → <150ms
- CLS: 0.136 → <0.05

---

## Testing Checklist

After each phase:
- [ ] Run Lighthouse audit (Desktop & Mobile)
- [ ] Test actual page load time di network throttling
- [ ] Test di berbagai devices (mobile, tablet, desktop)
- [ ] Test di berbagai browsers (Chrome, Firefox, Safari)
- [ ] Verify no JavaScript errors
- [ ] Verify carousel, buttons, forms still functional

---

## References

- [Web.dev - Core Web Vitals](https://web.dev/vitals/)
- [Jekyll Picture Tag Docs](https://rbuchberger.github.io/jekyll_picture_tag/)
- [Service Worker Docs](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)
- [PWA Checklist](https://web.dev/pwa-checklist/)

---

**Created by:** Claude Code
**Last Updated:** 2025-11-16
