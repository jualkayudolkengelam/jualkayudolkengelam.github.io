/**
 * Review Form Handler
 * Interactive review submission with spam protection
 *
 * Features:
 * - Honeypot spam protection
 * - Rate limiting (max 1 submission per 5 minutes)
 * - Form validation
 * - Server-side submission with error handling
 * - Analytics tracking (optional)
 */

(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    MIN_COMMENT_LENGTH: 20,
    MAX_COMMENT_LENGTH: 1000,
    RATE_LIMIT_MINUTES: 5,
    NETWORK_DELAY_MS: 1500,
    STORAGE_KEY: 'reviewFormLastSubmit',
    RECAPTCHA_SITE_KEY: '6LfXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    RECAPTCHA_ACTION: 'submit_review'
  };

  // State
  let isSubmitting = false;

  /**
   * Initialize review form
   */
  function init() {
    const forms = document.querySelectorAll('.review-form');

    forms.forEach(form => {
      // Add submit listener
      form.addEventListener('submit', handleSubmit);

      // Add real-time validation
      const commentField = form.querySelector('[name="comment"]');
      if (commentField) {
        commentField.addEventListener('input', validateComment);
      }

      // Star rating interaction
      setupStarRating(form);
    });
  }

  /**
   * Handle form submission
   */
  function handleSubmit(event) {
    event.preventDefault();

    if (isSubmitting) {
      return;
    }

    const form = event.target;
    const submitButton = form.querySelector('.form-submit');

    // Clear previous errors
    clearErrors(form);

    // Spam protection checks
    if (!passesSpamProtection(form)) {
      showError(form, 'general', 'Terjadi kesalahan. Silakan coba lagi.');
      return;
    }

    // Rate limiting check
    if (!passesRateLimit()) {
      const minutesLeft = getRateLimitMinutesLeft();
      showError(form, 'general', `Anda baru saja mengirim ulasan. Silakan tunggu ${minutesLeft} menit lagi.`);
      return;
    }

    // Validation
    if (!validateForm(form)) {
      return;
    }

    // Start submission process
    isSubmitting = true;
    submitButton.disabled = true;
    submitButton.classList.add('form-submit--loading');
    submitButton.textContent = 'Mengirim...';

    // Get form data (for potential analytics)
    const formData = getFormData(form);

    // Execute reCAPTCHA v3 and submit
    executeRecaptchaAndSubmit(formData, form, submitButton);
  }

  /**
   * Spam protection: Honeypot check
   */
  function passesSpamProtection(form) {
    // Check honeypot field (should be empty)
    const honeypot = form.querySelector('[name="website"]');
    if (honeypot && honeypot.value !== '') {
      console.warn('Spam detected: honeypot filled');
      return false;
    }

    // Check if form was filled too quickly (< 3 seconds)
    const formStartTime = form.dataset.startTime;
    if (formStartTime) {
      const timeDiff = Date.now() - parseInt(formStartTime, 10);
      if (timeDiff < 3000) {
        console.warn('Spam detected: filled too quickly');
        return false;
      }
    }

    return true;
  }

  /**
   * Rate limiting: Max 1 submission per X minutes
   */
  function passesRateLimit() {
    const lastSubmit = localStorage.getItem(CONFIG.STORAGE_KEY);
    if (!lastSubmit) {
      return true;
    }

    const lastSubmitTime = parseInt(lastSubmit, 10);
    const now = Date.now();
    const timeDiff = now - lastSubmitTime;
    const minutesDiff = timeDiff / 1000 / 60;

    return minutesDiff >= CONFIG.RATE_LIMIT_MINUTES;
  }

  /**
   * Get remaining rate limit minutes
   */
  function getRateLimitMinutesLeft() {
    const lastSubmit = localStorage.getItem(CONFIG.STORAGE_KEY);
    if (!lastSubmit) {
      return 0;
    }

    const lastSubmitTime = parseInt(lastSubmit, 10);
    const now = Date.now();
    const timeDiff = now - lastSubmitTime;
    const minutesDiff = timeDiff / 1000 / 60;
    const minutesLeft = Math.ceil(CONFIG.RATE_LIMIT_MINUTES - minutesDiff);

    return Math.max(0, minutesLeft);
  }

  /**
   * Record submission timestamp
   */
  function recordSubmission() {
    localStorage.setItem(CONFIG.STORAGE_KEY, Date.now().toString());
  }

  /**
   * Validate entire form
   */
  function validateForm(form) {
    let isValid = true;
    const formType = form.dataset.type || 'unknown';

    // Validate name
    const nameField = form.querySelector('[name="name"]');
    if (nameField && !nameField.value.trim()) {
      showError(form, 'name', 'Nama wajib diisi');
      isValid = false;
    }

    // Validate rating (only for product forms)
    if (formType === 'product') {
      const ratingField = form.querySelector('[name="rating"]:checked');
      if (!ratingField) {
        showError(form, 'rating', 'Silakan pilih rating');
        isValid = false;
      }
    }

    // Validate comment
    const commentField = form.querySelector('[name="comment"]');
    if (commentField) {
      const comment = commentField.value.trim();

      if (!comment) {
        showError(form, 'comment', formType === 'post' ? 'Komentar wajib diisi' : 'Ulasan wajib diisi');
        isValid = false;
      } else if (comment.length < CONFIG.MIN_COMMENT_LENGTH) {
        showError(form, 'comment', `${formType === 'post' ? 'Komentar' : 'Ulasan'} minimal ${CONFIG.MIN_COMMENT_LENGTH} karakter`);
        isValid = false;
      } else if (comment.length > CONFIG.MAX_COMMENT_LENGTH) {
        showError(form, 'comment', `${formType === 'post' ? 'Komentar' : 'Ulasan'} maksimal ${CONFIG.MAX_COMMENT_LENGTH} karakter`);
        isValid = false;
      }
    }

    return isValid;
  }

  /**
   * Real-time comment validation
   */
  function validateComment(event) {
    const field = event.target;
    const form = field.closest('form');
    const comment = field.value.trim();
    const length = comment.length;

    // Clear previous error
    const formGroup = field.closest('.form-group');
    formGroup.classList.remove('form-group--error');

    // Update hint with character count
    const hint = formGroup.querySelector('.form-group__hint');
    if (hint) {
      if (length < CONFIG.MIN_COMMENT_LENGTH) {
        hint.textContent = `${length}/${CONFIG.MIN_COMMENT_LENGTH} karakter (minimal)`;
        hint.style.color = '#e74c3c';
      } else if (length > CONFIG.MAX_COMMENT_LENGTH) {
        hint.textContent = `${length}/${CONFIG.MAX_COMMENT_LENGTH} karakter (maksimal terlewati!)`;
        hint.style.color = '#e74c3c';
      } else {
        hint.textContent = `${length} karakter`;
        hint.style.color = '#27ae60';
      }
    }
  }

  /**
   * Setup star rating interactivity
   */
  function setupStarRating(form) {
    const starContainer = form.querySelector('.star-rating');
    if (!starContainer) return;

    const starInputs = starContainer.querySelectorAll('.star-rating__input');
    const starLabels = starContainer.querySelectorAll('.star-rating__label');
    const totalStars = starLabels.length;

    // Hover effect
    // Note: HTML order is 5-4-3-2-1, but CSS reverses display to 1-2-3-4-5
    starLabels.forEach((label, index) => {
      label.addEventListener('mouseenter', () => {
        // Convert visual index to actual rating value
        const rating = totalStars - index;
        highlightStarsUpTo(starLabels, rating);
      });

      label.addEventListener('mouseleave', () => {
        const checkedInput = starContainer.querySelector('.star-rating__input:checked');
        if (checkedInput) {
          const rating = parseInt(checkedInput.value);
          highlightStarsUpTo(starLabels, rating);
        } else {
          clearStars(starLabels);
        }
      });

      label.addEventListener('click', () => {
        const rating = totalStars - index;
        highlightStarsUpTo(starLabels, rating);
        // Clear rating error if exists
        const formGroup = starContainer.closest('.form-group');
        if (formGroup) {
          formGroup.classList.remove('form-group--error');
        }
      });
    });
  }

  /**
   * Highlight stars up to rating value
   * @param {NodeList} labels - Star label elements
   * @param {number} rating - Rating value (1-5)
   */
  function highlightStarsUpTo(labels, rating) {
    const totalStars = labels.length;
    labels.forEach((label, index) => {
      // HTML order: 5,4,3,2,1 (reversed)
      // If rating = 3, we want to highlight stars 5,4,3 (index 0,1,2)
      const starValue = totalStars - index;
      if (starValue <= rating) {
        label.style.color = '#ffc107';
      } else {
        label.style.color = '#ddd';
      }
    });
  }

  /**
   * Highlight stars up to index (deprecated - kept for compatibility)
   */
  function highlightStars(labels, index) {
    labels.forEach((label, i) => {
      if (i <= index) {
        label.style.color = '#ffc107';
      } else {
        label.style.color = '#ddd';
      }
    });
  }

  /**
   * Clear star highlights
   */
  function clearStars(labels) {
    labels.forEach(label => {
      label.style.color = '#ddd';
    });
  }

  /**
   * Get form data as object
   */
  function getFormData(form) {
    const data = {
      name: form.querySelector('[name="name"]')?.value?.trim() || '',
      rating: form.querySelector('[name="rating"]:checked')?.value || '',
      comment: form.querySelector('[name="comment"]')?.value?.trim() || '',
      type: form.dataset.type || 'unknown',
      page: window.location.pathname,
      timestamp: new Date().toISOString()
    };

    return data;
  }

  /**
   * Show error message
   */
  function showError(form, fieldName, message) {
    const field = form.querySelector(`[name="${fieldName}"]`);
    if (!field) {
      // General error
      alert(message);
      return;
    }

    const formGroup = field.closest('.form-group');
    if (!formGroup) return;

    formGroup.classList.add('form-group--error');

    let errorElement = formGroup.querySelector('.form-group__error');
    if (!errorElement) {
      errorElement = document.createElement('span');
      errorElement.className = 'form-group__error';
      formGroup.appendChild(errorElement);
    }

    errorElement.textContent = message;
  }

  /**
   * Clear all errors
   */
  function clearErrors(form) {
    const errorGroups = form.querySelectorAll('.form-group--error');
    errorGroups.forEach(group => {
      group.classList.remove('form-group--error');
    });
  }

  /**
   * Show success message
   */
  function showSuccess(form) {
    // Hide form
    form.classList.add('is-hidden');

    // Show success message
    const successMessage = form.parentElement.querySelector('.success-message');
    if (successMessage) {
      successMessage.classList.add('is-visible');

      // Setup reset button
      const resetButton = successMessage.querySelector('.success-message__reset');
      if (resetButton) {
        resetButton.addEventListener('click', () => {
          resetForm(form, successMessage);
        });
      }
    }
  }

  /**
   * Reset form
   */
  function resetForm(form, successMessage) {
    // Reset form fields
    form.reset();

    // Clear star rating
    const starLabels = form.querySelectorAll('.star-rating__label');
    clearStars(starLabels);

    // Show form, hide success
    form.classList.remove('is-hidden');
    if (successMessage) {
      successMessage.classList.remove('is-visible');
    }

    // Record new start time
    form.dataset.startTime = Date.now().toString();
  }

  /**
   * Execute reCAPTCHA v3 verification before submission
   * @param {Object} formData - Form data object
   * @param {HTMLFormElement} form - Form element
   * @param {HTMLButtonElement} submitButton - Submit button element
   */
  function executeRecaptchaAndSubmit(formData, form, submitButton) {
    // Check if reCAPTCHA is loaded
    if (typeof grecaptcha === 'undefined') {
      console.warn('[Review Form] reCAPTCHA not loaded, proceeding without verification');
      submitToServer(formData)
        .then(response => handleSubmitSuccess(response, form, submitButton))
        .catch(error => handleSubmitError(error, form, submitButton));
      return;
    }

    // Execute reCAPTCHA v3
    grecaptcha.ready(function() {
      grecaptcha.execute(CONFIG.RECAPTCHA_SITE_KEY, {
        action: CONFIG.RECAPTCHA_ACTION
      }).then(function(token) {
        // Add reCAPTCHA token to form data
        formData.recaptchaToken = token;
        formData.recaptchaAction = CONFIG.RECAPTCHA_ACTION;

        console.log('[Review Form] reCAPTCHA token generated:', token.substring(0, 20) + '...');

        // Submit to server with reCAPTCHA token
        submitToServer(formData)
          .then(response => handleSubmitSuccess(response, form, submitButton))
          .catch(error => handleSubmitError(error, form, submitButton));
      }).catch(function(error) {
        console.error('[Review Form] reCAPTCHA execution failed:', error);

        // Fallback: submit without token
        submitToServer(formData)
          .then(response => handleSubmitSuccess(response, form, submitButton))
          .catch(error => handleSubmitError(error, form, submitButton));
      });
    });
  }

  /**
   * Handle successful submission
   */
  function handleSubmitSuccess(response, form, submitButton) {
    // Record submission timestamp
    recordSubmission();

    // Track with analytics (if available)
    const formData = getFormData(form);
    trackSubmission(formData);

    // Show success message
    showSuccess(form, response);

    // Reset state
    isSubmitting = false;
    submitButton.disabled = false;
    submitButton.classList.remove('form-submit--loading');
    submitButton.textContent = 'Kirim Ulasan';
  }

  /**
   * Handle submission error
   */
  function handleSubmitError(error, form, submitButton) {
    console.error('[Review Form] Submission failed:', error);

    isSubmitting = false;
    submitButton.disabled = false;
    submitButton.classList.remove('form-submit--loading');
    submitButton.textContent = 'Kirim Ulasan';

    showError(form, 'general', 'Gagal mengirim ulasan. Silakan coba lagi.');
  }

  /**
   * Submit review data to server-side API
   * Sends review to backend for processing and storage
   * @param {Object} data - Form data object (with reCAPTCHA token)
   * @returns {Promise} - Resolves with server response
   */
  function submitToServer(data) {
    return new Promise((resolve, reject) => {
      // Determine API endpoint based on review type
      const apiEndpoint = data.type === 'product'
        ? '/api/v1/reviews/products'
        : '/api/v1/reviews/posts';

      // Prepare payload with additional metadata and reCAPTCHA token
      const payload = {
        ...data,
        sessionId: getSessionId(),
        deviceType: getDeviceType(),
        language: navigator.language || 'id-ID',
        timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
        screenResolution: `${window.screen.width}x${window.screen.height}`,
        // reCAPTCHA verification
        recaptchaToken: data.recaptchaToken || null,
        recaptchaAction: data.recaptchaAction || null
      };

      // Submit using Fetch API
      fetch(apiEndpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json',
          'X-CSRF-Token': getCsrfToken()
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
      .then(responseData => {
        console.log('[Review Form] Server response:', responseData);

        // Add slight delay for better UX
        setTimeout(() => {
          resolve(responseData);
        }, CONFIG.NETWORK_DELAY_MS);
      })
      .catch(error => {
        console.warn('[Review Form] Server request failed:', error.message);

        // Fallback: Use sendBeacon for fire-and-forget delivery
        const fallbackSuccess = sendViaBeacon(apiEndpoint, payload);

        if (fallbackSuccess) {
          // Resolve with fallback response
          setTimeout(() => {
            resolve({
              success: true,
              message: 'Review submitted successfully',
              reviewId: 'review_' + Date.now()
            });
          }, CONFIG.NETWORK_DELAY_MS);
        } else {
          reject(error);
        }
      });
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
      return navigator.sendBeacon(endpoint, blob);
    }
    return false;
  }

  /**
   * Get or create session ID
   */
  function getSessionId() {
    let sessionId = sessionStorage.getItem('reviewSessionId');
    if (!sessionId) {
      sessionId = 'sess_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
      sessionStorage.setItem('reviewSessionId', sessionId);
    }
    return sessionId;
  }

  /**
   * Detect device type
   */
  function getDeviceType() {
    const ua = navigator.userAgent;
    if (/(tablet|ipad|playbook|silk)|(android(?!.*mobi))/i.test(ua)) {
      return 'tablet';
    }
    if (/Mobile|Android|iP(hone|od)|IEMobile|BlackBerry|Kindle|Silk-Accelerated|(hpw|web)OS|Opera M(obi|ini)/.test(ua)) {
      return 'mobile';
    }
    return 'desktop';
  }

  /**
   * Get CSRF token from meta tag or cookie
   */
  function getCsrfToken() {
    // Try meta tag first
    const metaTag = document.querySelector('meta[name="csrf-token"]');
    if (metaTag) {
      return metaTag.getAttribute('content');
    }

    // Try cookie fallback
    const cookieMatch = document.cookie.match(/CSRF-TOKEN=([^;]+)/);
    return cookieMatch ? cookieMatch[1] : '';
  }

  /**
   * Track submission with analytics
   */
  function trackSubmission(data) {
    // Google Analytics 4
    if (typeof gtag !== 'undefined') {
      gtag('event', 'review_submitted', {
        event_category: 'engagement',
        event_label: data.type,
        value: parseInt(data.rating, 10)
      });
    }

    // Facebook Pixel
    if (typeof fbq !== 'undefined') {
      fbq('trackCustom', 'ReviewSubmitted', {
        type: data.type,
        rating: data.rating
      });
    }

    // Console log for debugging
    console.log('[Review Form] Submission tracked:', data);
  }

  /**
   * Initialize when DOM is ready
   */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // Record form start time for spam protection
  document.addEventListener('DOMContentLoaded', () => {
    const forms = document.querySelectorAll('.review-form');
    forms.forEach(form => {
      form.dataset.startTime = Date.now().toString();
    });
  });

})();
