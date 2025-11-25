/**
 * Article Feedback Handler (Inline Like/Dislike)
 * Positioned inline within article content
 *
 * Features:
 * - Inline horizontal layout with counters
 * - Like and Dislike buttons
 * - LocalStorage for user preference
 * - Toast notifications
 * - Thank you message
 * - Smooth animations
 */

(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    STORAGE_KEY_PREFIX: 'articleFeedback_',
    ANIMATION_DURATION: 300,
    NOTIFICATION_DURATION: 2500,
    COOLDOWN_MS: 1000,
    RECAPTCHA_SITE_KEY: '6LfXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    RECAPTCHA_ACTION: 'article_feedback_interaction'
  };

  // State
  let lastClickTime = 0;
  let likeButton = null;
  let dislikeButton = null;
  let thankYouMessage = null;
  let currentPageKey = null;

  /**
   * Initialize Article Feedback functionality
   */
  function init() {
    // Generate unique key for current page
    currentPageKey = CONFIG.STORAGE_KEY_PREFIX + getPageKey();

    // Get button elements
    likeButton = document.querySelector('.article-feedback__button--like');
    dislikeButton = document.querySelector('.article-feedback__button--dislike');
    thankYouMessage = document.querySelector('.article-feedback__thank-you');

    if (!likeButton || !dislikeButton) {
      console.warn('[Article Feedback] Buttons not found');
      return;
    }

    // Load saved state
    loadSavedState();

    // Add click listeners
    likeButton.addEventListener('click', handleLikeClick);
    dislikeButton.addEventListener('click', handleDislikeClick);

    console.log('[Article Feedback] Initialized');
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
      hideThankYouMessage();
      showNotification('Feedback dibatalkan', 'neutral');
    } else {
      // User is liking (either new or switching from dislike)
      setLike();
      showThankYouMessage();
      showNotification('Terima kasih! Feedback Anda sangat berarti 👍', 'success');
      animateButton(likeButton);
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
      hideThankYouMessage();
      showNotification('Feedback dibatalkan', 'neutral');
    } else {
      // User is disliking (either new or switching from like)
      setDislike();
      showThankYouMessage();
      showNotification('Terima kasih atas feedback Anda', 'info');
      animateButton(dislikeButton);
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

    if (state) {
      showThankYouMessage();
    }
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
  function animateButton(button) {
    button.classList.add('is-animating');

    setTimeout(() => {
      button.classList.remove('is-animating');
    }, CONFIG.ANIMATION_DURATION);
  }

  /**
   * Show thank you message
   */
  function showThankYouMessage() {
    if (thankYouMessage) {
      thankYouMessage.style.display = 'flex';
      thankYouMessage.classList.add('is-visible');
    }
  }

  /**
   * Hide thank you message
   */
  function hideThankYouMessage() {
    if (thankYouMessage) {
      thankYouMessage.classList.remove('is-visible');
      setTimeout(() => {
        thankYouMessage.style.display = 'none';
      }, 300);
    }
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
   * Track interaction with analytics
   */
  function trackInteraction(action, previousState) {
    // Execute reCAPTCHA v3 before sending to server
    executeRecaptchaAndTrack(action, previousState);

    // Google Analytics 4
    if (typeof gtag !== 'undefined') {
      gtag('event', 'article_feedback_interaction', {
        event_category: 'engagement',
        event_label: action,
        previous_state: previousState || 'none',
        page_path: window.location.pathname
      });
    }

    // Facebook Pixel
    if (typeof fbq !== 'undefined') {
      fbq('trackCustom', 'ArticleFeedbackClick', {
        action: action,
        page: window.location.pathname
      });
    }

    console.log('[Article Feedback] Interaction:', {
      action: action,
      previousState: previousState || 'none',
      page: window.location.pathname
    });
  }

  /**
   * Execute reCAPTCHA v3 verification before tracking
   */
  function executeRecaptchaAndTrack(action, previousState) {
    if (typeof grecaptcha === 'undefined') {
      console.warn('[Article Feedback] reCAPTCHA not loaded, proceeding without verification');
      submitToServer(action, previousState, null);
      return;
    }

    grecaptcha.ready(function() {
      grecaptcha.execute(CONFIG.RECAPTCHA_SITE_KEY, {
        action: CONFIG.RECAPTCHA_ACTION
      }).then(function(token) {
        console.log('[Article Feedback] reCAPTCHA token generated');
        submitToServer(action, previousState, token);
      }).catch(function(error) {
        console.error('[Article Feedback] reCAPTCHA execution failed:', error);
        submitToServer(action, previousState, null);
      });
    });
  }

  /**
   * Submit interaction data to server
   */
  function submitToServer(action, previousState, recaptchaToken) {
    const payload = {
      action: action,
      previousState: previousState || 'none',
      pageUrl: window.location.pathname,
      pageTitle: document.title,
      timestamp: new Date().toISOString(),
      userAgent: navigator.userAgent,
      referrer: document.referrer || 'direct',
      recaptchaToken: recaptchaToken,
      recaptchaAction: CONFIG.RECAPTCHA_ACTION
    };

    const apiEndpoint = '/api/v1/engagement/article-feedback';

    fetch(apiEndpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json'
      },
      body: JSON.stringify(payload),
      credentials: 'same-origin',
      keepalive: true
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      console.log('[Article Feedback] Server response:', data);

      if (data.aggregates) {
        updateAggregateDisplay(data.aggregates);
      }
    })
    .catch(error => {
      console.warn('[Article Feedback] Server request failed (graceful degradation):', error.message);
      sendViaBeacon(apiEndpoint, payload);
    });
  }

  /**
   * Fallback: Use Navigator.sendBeacon
   */
  function sendViaBeacon(endpoint, payload) {
    if (navigator.sendBeacon) {
      const blob = new Blob([JSON.stringify(payload)], {
        type: 'application/json'
      });
      const success = navigator.sendBeacon(endpoint, blob);

      if (success) {
        console.log('[Article Feedback] Sent via Beacon API');
      }
    }
  }

  /**
   * Update aggregate statistics display
   */
  function updateAggregateDisplay(aggregates) {
    if (aggregates.totalLikes !== undefined) {
      const likeCount = document.querySelector('[data-count="like"]');
      if (likeCount) {
        likeCount.textContent = aggregates.totalLikes;
      }
    }

    if (aggregates.totalDislikes !== undefined) {
      const dislikeCount = document.querySelector('[data-count="dislike"]');
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
