/**
 * ============================================================================
 * Sidebar Table of Contents Generator
 * ============================================================================
 *
 * @file        sidebar-toc.js
 * @path        assets/js/sidebar-toc.js
 * @description Auto-generates table of contents from H2 and H3 headings
 * @version     1.0.0
 * @date        2025-11-20
 * @author      arisciwek
 *
 * Features:
 * ---------
 * - Auto-generate ToC from post content headings
 * - Smooth scroll to sections
 * - Collapsible dropdown with animated chevron
 * - Hierarchical display (H2 and H3 with indentation)
 * - Auto-add IDs to headings if missing
 *
 * Usage:
 * ------
 * Include this script in layout that has:
 * - Element with id="sidebar-toc" (ToC container)
 * - Element with class="post-body" (content area)
 * - Collapsible element with id="tocCollapse"
 *
 * ============================================================================
 */

(function() {
  'use strict';

  const toc = document.getElementById('sidebar-toc');
  if (!toc) return;

  // Find all H2 and H3 in post content
  const content = document.querySelector('.post-body');
  if (!content) return;

  const headings = content.querySelectorAll('h2, h3');
  if (headings.length === 0) {
    toc.innerHTML = '<p class="text-muted small mb-0">Tidak ada daftar isi</p>';
    return;
  }

  // Build ToC list
  const ul = document.createElement('ul');
  ul.className = 'list-unstyled mb-0';

  headings.forEach((heading, index) => {
    // Add ID to heading if not exists
    if (!heading.id) {
      heading.id = 'heading-' + index;
    }

    const li = document.createElement('li');
    li.className = 'mb-2';

    const a = document.createElement('a');
    a.href = '#' + heading.id;
    a.className = 'text-decoration-none text-muted d-block';
    a.style.fontSize = heading.tagName === 'H3' ? '0.85rem' : '0.9rem';
    a.style.paddingLeft = heading.tagName === 'H3' ? '1rem' : '0';
    a.textContent = heading.textContent;

    // Smooth scroll on click
    a.addEventListener('click', (e) => {
      e.preventDefault();
      heading.scrollIntoView({ behavior: 'smooth', block: 'start' });
      window.history.pushState(null, null, '#' + heading.id);
    });

    li.appendChild(a);
    ul.appendChild(li);
  });

  toc.appendChild(ul);

  // Rotate chevron icon on collapse toggle
  const tocCollapse = document.getElementById('tocCollapse');
  const chevronIcon = document.querySelector('[data-bs-target="#tocCollapse"] .bi-chevron-down');

  if (tocCollapse && chevronIcon) {
    tocCollapse.addEventListener('show.bs.collapse', function() {
      chevronIcon.style.transform = 'rotate(180deg)';
      chevronIcon.style.transition = 'transform 0.3s ease';
    });

    tocCollapse.addEventListener('hide.bs.collapse', function() {
      chevronIcon.style.transform = 'rotate(0deg)';
    });
  }

})();
