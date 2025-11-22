/**
 * Contact Form Handler
 *
 * Handles contact form submission and redirects to WhatsApp
 * Used in contact.html page
 *
 * @version 1.0.1
 * @date 2025-11-22
 * @author arisciwek
 */

document.addEventListener('DOMContentLoaded', function() {
  console.log('[Contact Form] Script loaded');

  const contactForm = document.getElementById('quickContactForm');

  if (!contactForm) {
    console.error('[Contact Form] Form element not found with ID: quickContactForm');
    return;
  }

  console.log('[Contact Form] Form found:', contactForm);
  console.log('[Contact Form] WhatsApp number from data-attribute:', contactForm.dataset.whatsapp);

  contactForm.addEventListener('submit', function(e) {
    e.preventDefault();
    console.log('[Contact Form] Form submitted');

    // Get form values
    const name = document.getElementById('name').value;
    const phone = document.getElementById('phone').value;
    const productType = document.getElementById('productType').value;
    const quantity = document.getElementById('quantity').value;
    const city = document.getElementById('city').value;
    const message = document.getElementById('message').value;

    console.log('[Contact Form] Form data:', { name, phone, productType, quantity, city, message });

    // Build WhatsApp message
    let whatsappMessage = `Halo, saya ${name}.\n\n`;

    if (productType) {
      whatsappMessage += `Saya tertarik dengan kayu dolken diameter ${productType}.\n`;
    }

    if (quantity) {
      whatsappMessage += `Kebutuhan: ${quantity}\n`;
    }

    if (city) {
      whatsappMessage += `Lokasi pengiriman: ${city}\n`;
    }

    if (message) {
      whatsappMessage += `\nPesan:\n${message}\n`;
    }

    whatsappMessage += `\nNomor WhatsApp saya: ${phone}`;

    console.log('[Contact Form] WhatsApp message:', whatsappMessage);

    const encodedMessage = encodeURIComponent(whatsappMessage);

    // Get WhatsApp number from data attribute or global variable
    const whatsappNumber = contactForm.dataset.whatsapp || window.businessWhatsApp || '';

    if (!whatsappNumber) {
      console.error('[Contact Form] WhatsApp number not found!');
      alert('Error: Nomor WhatsApp tidak tersedia. Silakan hubungi admin.');
      return;
    }

    console.log('[Contact Form] WhatsApp number:', whatsappNumber);

    const whatsappURL = `https://wa.me/${whatsappNumber}?text=${encodedMessage}`;

    console.log('[Contact Form] Opening WhatsApp URL:', whatsappURL);

    // Try to open in new window
    const newWindow = window.open(whatsappURL, '_blank');

    if (!newWindow || newWindow.closed || typeof newWindow.closed == 'undefined') {
      console.warn('[Contact Form] Popup blocked! Trying fallback...');
      // Fallback: redirect in same window
      window.location.href = whatsappURL;
    } else {
      console.log('[Contact Form] WhatsApp window opened successfully');
    }
  });
});
