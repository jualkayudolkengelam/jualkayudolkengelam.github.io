/**
 * Post Carousel Initializer
 *
 * Initializes Bootstrap carousel for post image galleries
 * Used in node--post-with-product.html layout
 *
 * @version 1.0.0
 * @date 2025-11-19
 * @author arisciwek
 */

document.addEventListener('DOMContentLoaded', function() {
  var carouselElement = document.getElementById('postCarousel');

  if (carouselElement && typeof bootstrap !== 'undefined') {
    // Initialize carousel manually
    var carousel = new bootstrap.Carousel(carouselElement, {
      interval: 3000,      // Auto-slide every 3 seconds
      ride: 'carousel',    // Start cycling automatically
      pause: 'hover',      // Pause on hover
      wrap: true,          // Continuous loop
      keyboard: true,      // Keyboard navigation enabled
      touch: true          // Touch/swipe support
    });
  }
});
