/**
 * Bootstrap Carousel Initializer
 *
 * Initializes Bootstrap carousel for image galleries
 * Used in node--post-with-product.html and node--product.html layouts
 *
 * Supports multiple carousel instances:
 * - #postCarousel (for blog posts)
 * - #productCarousel (for product pages)
 *
 * @version 1.1.0
 * @date 2025-11-19
 * @author arisciwek
 */

document.addEventListener('DOMContentLoaded', function() {
  // Check if Bootstrap is available
  if (typeof bootstrap === 'undefined') {
    return;
  }

  // Default carousel configuration
  var carouselConfig = {
    interval: 3000,      // Auto-slide every 3 seconds
    ride: 'carousel',    // Start cycling automatically
    pause: 'hover',      // Pause on hover
    wrap: true,          // Continuous loop
    keyboard: true,      // Keyboard navigation enabled
    touch: true          // Touch/swipe support
  };

  // Initialize all carousels on the page
  var carouselIds = ['postCarousel', 'productCarousel'];

  carouselIds.forEach(function(carouselId) {
    var carouselElement = document.getElementById(carouselId);
    if (carouselElement) {
      new bootstrap.Carousel(carouselElement, carouselConfig);
    }
  });
});
