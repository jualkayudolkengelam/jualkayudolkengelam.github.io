/**
 * Like/Dislike Buttons Handler
 * Floating buttons positioned above the review FAB
 *
 * Features:
 * - Like and Dislike buttons with animations
 * - Toast notifications on click
 * - Local storage to persist user preferences
 * - Smooth animations and transitions
 */

(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    STORAGE_KEY_PREFIX: 'likeDislike_',
    ANIMATION_DURATION: 300,
    NOTIFICATION_DURATION: 2500,
    COOLDOWN_MS: 1000 // Prevent spam clicking
  };

  // State
  let lastClickTime = 0;
  let likeButton = null;
  let dislikeButton = null;
  let currentPageKey = null;

  /**
   * Initialize Like/Dislike functionality
   */
  function init() {
    // Generate unique key for current page
    currentPageKey = CONFIG.STORAGE_KEY_PREFIX + getPageKey();

    // Get button elements
    likeButton = document.querySelector('.like-dislike-buttons__like');
    dislikeButton = document.querySelector('.like-dislike-buttons__dislike');

    if (!likeButton || !dislikeButton) {
      console.warn('[Like/Dislike] Buttons not found');
      return;
    }

    // Load saved state
    loadSavedState();

    // Add click listeners
    likeButton.addEventListener('click', handleLikeClick);
    dislikeButton.addEventListener('click', handleDislikeClick);

    // Add hover effects
    setupHoverEffects();

    console.log('[Like/Dislike] Initialized');
  }

  /**
   * Generate unique key for current page
   */
  function getPageKey() {
    return window.location.pathname.replace(/\//g, '_') || 'home';
  }

  /**
   * Handle Like button click
   */
  function handleLikeClick(event) {
    event.preventDefault();

    if (!canClick()) {
      return;
    }

    const currentState = getSavedState();

    if (currentState === 'like') {
      // User is removing their like
      removeLike();
      showNotification('Like dibatalkan', 'neutral');
    } else {
      // User is liking (either new or switching from dislike)
      setLike();
      showNotification('Terima kasih atas Like-nya! 👍', 'success');
      animateButton(likeButton, 'like');
    }

    updateButtonStates();
    trackInteraction('like', currentState);
  }

  /**
   * Handle Dislike button click
   */
  function handleDislikeClick(event) {
    event.preventDefault();

    if (!canClick()) {
      return;
    }

    const currentState = getSavedState();

    if (currentState === 'dislike') {
      // User is removing their dislike
      removeDislike();
      showNotification('Dislike dibatalkan', 'neutral');
    } else {
      // User is disliking (either new or switching from like)
      setDislike();
      showNotification('Terima kasih atas feedback-nya', 'info');
      animateButton(dislikeButton, 'dislike');
    }

    updateButtonStates();
    trackInteraction('dislike', currentState);
  }

  /**
   * Check if user can click (cooldown protection)
   */
  function canClick() {
    const now = Date.now();
    if (now - lastClickTime < CONFIG.COOLDOWN_MS) {
      return false;
    }
    lastClickTime = now;
    return true;
  }

  /**
   * Save like state
   */
  function setLike() {
    localStorage.setItem(currentPageKey, 'like');
  }

  /**
   * Save dislike state
   */
  function setDislike() {
    localStorage.setItem(currentPageKey, 'dislike');
  }

  /**
   * Remove like state
   */
  function removeLike() {
    localStorage.removeItem(currentPageKey);
  }

  /**
   * Remove dislike state
   */
  function removeDislike() {
    localStorage.removeItem(currentPageKey);
  }

  /**
   * Get saved state
   */
  function getSavedState() {
    return localStorage.getItem(currentPageKey);
  }

  /**
   * Load and apply saved state
   */
  function loadSavedState() {
    const state = getSavedState();
    updateButtonStates(state);
  }

  /**
   * Update button visual states
   */
  function updateButtonStates(state) {
    if (!state) {
      state = getSavedState();
    }

    // Reset both buttons first
    likeButton.classList.remove('is-active');
    dislikeButton.classList.remove('is-active');

    // Apply active state
    if (state === 'like') {
      likeButton.classList.add('is-active');
    } else if (state === 'dislike') {
      dislikeButton.classList.add('is-active');
    }
  }

  /**
   * Animate button on click
   */
  function animateButton(button, type) {
    // Add animation class
    button.classList.add('is-animating');

    // Create floating icon animation
    createFloatingIcon(button, type);

    // Remove animation class after duration
    setTimeout(() => {
      button.classList.remove('is-animating');
    }, CONFIG.ANIMATION_DURATION);
  }

  /**
   * Create floating icon animation
   */
  function createFloatingIcon(button, type) {
    const icon = document.createElement('div');
    icon.className = 'like-dislike-float-icon';
    icon.textContent = type === 'like' ? '👍' : '👎';

    // Position relative to button
    const rect = button.getBoundingClientRect();
    icon.style.left = rect.left + (rect.width / 2) + 'px';
    icon.style.top = rect.top + 'px';

    document.body.appendChild(icon);

    // Remove after animation
    setTimeout(() => {
      icon.remove();
    }, 1000);
  }

  /**
   * Show notification toast
   */
  function showNotification(message, type = 'success') {
    // Remove existing notification if any
    const existing = document.querySelector('.like-dislike-notification');
    if (existing) {
      existing.remove();
    }

    // Create notification element
    const notification = document.createElement('div');
    notification.className = `like-dislike-notification like-dislike-notification--${type}`;
    notification.textContent = message;

    document.body.appendChild(notification);

    // Trigger animation
    setTimeout(() => {
      notification.classList.add('is-visible');
    }, 10);

    // Auto remove
    setTimeout(() => {
      notification.classList.remove('is-visible');
      setTimeout(() => {
        notification.remove();
      }, 300);
    }, CONFIG.NOTIFICATION_DURATION);
  }

  /**
   * Setup hover effects
   */
  function setupHoverEffects() {
    // Like button hover
    likeButton.addEventListener('mouseenter', function() {
      if (!this.classList.contains('is-active')) {
        this.style.transform = 'scale(1.1) translateY(-2px)';
      }
    });

    likeButton.addEventListener('mouseleave', function() {
      this.style.transform = '';
    });

    // Dislike button hover
    dislikeButton.addEventListener('mouseenter', function() {
      if (!this.classList.contains('is-active')) {
        this.style.transform = 'scale(1.1) translateY(-2px)';
      }
    });

    dislikeButton.addEventListener('mouseleave', function() {
      this.style.transform = '';
    });
  }

  /**
   * Track interaction with analytics
   */
  function trackInteraction(action, previousState) {
    // Send to server-side API endpoint for persistence
    submitToServer(action, previousState);

    // Google Analytics 4
    if (typeof gtag !== 'undefined') {
      gtag('event', 'like_dislike_interaction', {
        event_category: 'engagement',
        event_label: action,
        previous_state: previousState || 'none',
        page_path: window.location.pathname
      });
    }

    // Facebook Pixel
    if (typeof fbq !== 'undefined') {
      fbq('trackCustom', 'LikeDislikeClick', {
        action: action,
        page: window.location.pathname
      });
    }

    // Console log for debugging
    console.log('[Like/Dislike] Interaction:', {
      action: action,
      previousState: previousState || 'none',
      page: window.location.pathname
    });
  }

  /**
   * Submit interaction data to server-side API
   * Sends POST request to track user engagement
   * for analytics and aggregate statistics
   */
  function submitToServer(action, previousState) {
    // Prepare payload for server
    const payload = {
      action: action,
      previousState: previousState || 'none',
      pageUrl: window.location.pathname,
      pageTitle: document.title,
      timestamp: new Date().toISOString(),
      userAgent: navigator.userAgent,
      referrer: document.referrer || 'direct'
    };

    // API endpoint configuration
    const apiEndpoint = '/api/v1/engagement/like-dislike';

    // Use Fetch API to send data to server
    fetch(apiEndpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json'
      },
      body: JSON.stringify(payload),
      credentials: 'same-origin',
      // Use keepalive to ensure request completes even if page unloads
      keepalive: true
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      // Handle successful server response
      console.log('[Like/Dislike] Server response:', data);

      // Update aggregate counts if provided by server
      if (data.aggregates) {
        updateAggregateDisplay(data.aggregates);
      }
    })
    .catch(error => {
      // Silently fail - user interaction already saved locally
      console.warn('[Like/Dislike] Server request failed (graceful degradation):', error.message);

      // Fallback: Store in IndexedDB or send via beacon API
      sendViaBeacon(apiEndpoint, payload);
    });
  }

  /**
   * Fallback: Use Navigator.sendBeacon for reliable delivery
   */
  function sendViaBeacon(endpoint, payload) {
    if (navigator.sendBeacon) {
      const blob = new Blob([JSON.stringify(payload)], {
        type: 'application/json'
      });
      const success = navigator.sendBeacon(endpoint, blob);

      if (success) {
        console.log('[Like/Dislike] Sent via Beacon API');
      }
    }
  }

  /**
   * Update aggregate statistics display
   */
  function updateAggregateDisplay(aggregates) {
    // Optional: Display total likes/dislikes if server provides them
    if (aggregates.totalLikes !== undefined) {
      const likeCount = document.querySelector('[data-like-count]');
      if (likeCount) {
        likeCount.textContent = aggregates.totalLikes;
      }
    }

    if (aggregates.totalDislikes !== undefined) {
      const dislikeCount = document.querySelector('[data-dislike-count]');
      if (dislikeCount) {
        dislikeCount.textContent = aggregates.totalDislikes;
      }
    }
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
