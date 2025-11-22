# Nested Block Pattern

## Konsep

Nested block adalah pattern dimana satu block (parent) memanggil block lain (child) di dalamnya. Ini memisahkan tanggung jawab antara **logic** dan **presentation**.

## Arsitektur

```
Parent Block (Logic Layer)
├── Data fetching & filtering
├── Sorting & calculations
├── Section wrapper & title
└── Loop items
    └── Child Block (Presentation Layer)
        └── Render single item
```

## Benefits

1. **Separation of Concerns**
   - Parent: What to show (logic)
   - Child: How to show it (presentation)

2. **DRY Principle**
   - Child block reusable di berbagai parent
   - Satu perubahan UI, apply ke semua

3. **Flexibility**
   - Ganti logic tanpa ubah UI
   - Ganti UI tanpa ubah logic

4. **Maintainability**
   - Kode lebih modular
   - Easier to debug
   - Cleaner separation

## Example: Product Blocks

### Parent Block: `block--related-product-last-modified.html`

**Responsibility:**
- Sort products by `last_modified_at`
- Select top 3 products
- Generate ItemList schema
- Provide section wrapper & title

**Code:**
```liquid
{% assign sorted_products = site.products | sort: "last_modified_at" | reverse %}
{% assign selected_products = sorted_products | slice: 0, 3 %}

<section class="related-products-section">
  <h3>Produk Terbaru</h3>
  <div class="row">
    {% for product in selected_products %}
    <div class="col-md-4">
      {% include reusable/block--product.html
         product=product
         variant="card"
         show_schema=false
      %}
    </div>
    {% endfor %}
  </div>
</section>
```

### Child Block: `block--product.html`

**Responsibility:**
- Render single product card
- Handle variants (standard, compact, featured)
- Optionally include product schema

**Code:**
```liquid
{% assign product = include.product %}
{% assign variant = include.variant | default: "standard" %}

<div class="card product-card">
  <img src="{{ product.image }}" alt="{{ product.title }}">
  <div class="card-body">
    <h4>{{ product.title }}</h4>
    <p>Rp {{ product.price }}</p>
    <a href="{{ product.url }}">Detail</a>
  </div>
</div>
```

## Usage Examples

### 1. Different Selection Strategies, Same UI

```liquid
<!-- Last Modified Strategy -->
{% include reusable/block--related-product-last-modified.html %}
└── calls block--product.html

<!-- Node-based Strategy -->
{% include reusable/block--related-product--by-node.html %}
└── calls block--product.html

<!-- Category Strategy -->
{% include reusable/block--related-product--by-category.html %}
└── calls block--product.html
```

Same `block--product.html`, different parent blocks!

### 2. Custom Parameters

```liquid
<!-- Show 5 products instead of 3 -->
{% include reusable/block--related-product-last-modified.html
   limit=5
   title="Top 5 Produk Terbaru"
%}

<!-- Different variant -->
{% for product in site.products limit:3 %}
  {% include reusable/block--product.html
     product=product
     variant="featured"
     show_schema=true
  %}
{% endfor %}
```

## Naming Convention

### Parent Blocks (Logic)
```
block--related-{type}--by-{strategy}.html
```
Examples:
- `block--related-product--by-last-modified.html`
- `block--related-product--by-node.html`
- `block--related-content--by-category.html`

### Child Blocks (Presentation)
```
block--{entity}.html
```
Examples:
- `block--product.html`
- `block--post.html`
- `block--article.html`

## Best Practices

1. **Parent blocks should:**
   - Handle data selection & filtering
   - Manage section-level schema (ItemList, CollectionPage)
   - Provide container/wrapper HTML
   - Pass clean data to children

2. **Child blocks should:**
   - Focus on rendering single item
   - Be reusable across different parents
   - Support variants via parameters
   - Manage item-level schema (Product, Article)

3. **Parameters:**
   - Always provide sensible defaults
   - Document all parameters clearly
   - Use consistent naming

## Migration Path

### Before (Monolithic)
```liquid
<!-- block--related-product-old.html -->
<section>
  {% assign products = site.products | sort: "date" %}
  {% for product in products limit:3 %}
    <!-- 50 lines of product card HTML here -->
  {% endfor %}
</section>
```

### After (Nested)
```liquid
<!-- Parent: block--related-product-last-modified.html -->
<section>
  {% assign products = site.products | sort: "date" %}
  {% for product in products limit:3 %}
    {% include reusable/block--product.html product=product %}
  {% endfor %}
</section>

<!-- Child: block--product.html -->
<!-- 50 lines of reusable product card HTML -->
```

## Real World Example

In our project:

```
index.html (homepage)
├── block--related-product-last-modified.html (parent)
│   └── block--product.html (child)
│
blog.html (blog listing)
├── block--related-product--by-node.html (parent)
│   └── block--product.html (child)  ← SAME CHILD!
│
product/detail.html
├── block--related-product--by-category.html (parent)
│   └── block--product.html (child)  ← SAME CHILD!
```

One `block--product.html`, used everywhere!

## Conclusion

Nested block pattern adalah cara yang powerful untuk membuat kode yang:
- ✅ Modular
- ✅ Reusable
- ✅ Maintainable
- ✅ Flexible
- ✅ Following DRY principle

Use this pattern whenever you have:
- Repeated UI components
- Multiple data selection strategies
- Need for flexibility in presentation
