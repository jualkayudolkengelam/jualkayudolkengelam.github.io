/**
 * Review Modal Handler
 * Handles floating button and modal pop-up functionality
 */

(function() {
  'use strict';

  let modalOverlay = null;
  let modal = null;
  let fab = null;

  /**
   * Initialize modal functionality
   */
  function init() {
    modalOverlay = document.querySelector('.review-modal-overlay');
    modal = document.querySelector('.review-modal');
    fab = document.querySelector('.review-fab');

    if (!modalOverlay || !modal || !fab) {
      return;
    }

    // FAB click - open modal
    fab.addEventListener('click', openModal);

    // Close button click
    const closeButton = modal.querySelector('.review-modal__close');
    if (closeButton) {
      closeButton.addEventListener('click', closeModal);
    }

    // Overlay click - close modal
    modalOverlay.addEventListener('click', closeModal);

    // Prevent modal content click from closing
    modal.addEventListener('click', function(e) {
      e.stopPropagation();
    });

    // ESC key - close modal
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape' && modal.classList.contains('is-active')) {
        closeModal();
      }
    });

    // Listen for successful form submission
    document.addEventListener('reviewSubmitted', function() {
      // Keep modal open to show success message
      // Modal will be closed when user clicks "Kirim Ulasan Lain"
    });
  }

  /**
   * Open modal
   */
  function openModal() {
    if (!modal || !modalOverlay) return;

    // Add active classes
    modalOverlay.classList.add('is-active');
    modal.classList.add('is-active');
    fab.classList.add('is-hidden');

    // Prevent body scroll
    document.body.classList.add('review-modal-open');

    // Focus first input
    setTimeout(() => {
      const firstInput = modal.querySelector('input[type="text"]');
      if (firstInput) {
        firstInput.focus();
      }
    }, 300);

    // Track modal open
    trackModalEvent('open');
  }

  /**
   * Close modal
   */
  function closeModal() {
    if (!modal || !modalOverlay) return;

    // Remove active classes
    modalOverlay.classList.remove('is-active');
    modal.classList.remove('is-active');
    fab.classList.remove('is-hidden');

    // Re-enable body scroll
    document.body.classList.remove('review-modal-open');

    // Reset form if success message is showing
    setTimeout(() => {
      const form = modal.querySelector('.review-form');
      const successMessage = modal.querySelector('.success-message');

      if (form && successMessage && successMessage.classList.contains('is-visible')) {
        // Reset form
        form.reset();
        form.classList.remove('is-hidden');
        successMessage.classList.remove('is-visible');

        // Clear star rating
        const starLabels = form.querySelectorAll('.star-rating__label');
        starLabels.forEach(label => {
          label.style.filter = 'grayscale(1)';
          label.style.opacity = '0.3';
        });

        // Reset start time
        form.dataset.startTime = Date.now().toString();
      }
    }, 300);

    // Track modal close
    trackModalEvent('close');
  }

  /**
   * Track modal events
   */
  function trackModalEvent(action) {
    // Google Analytics 4
    if (typeof gtag !== 'undefined') {
      gtag('event', `review_modal_${action}`, {
        event_category: 'engagement',
        event_label: window.location.pathname
      });
    }

    // Console log for debugging
    console.log(`[Review Modal] ${action}`);
  }

  /**
   * Initialize when DOM is ready
   */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();
