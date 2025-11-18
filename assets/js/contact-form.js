/**
 * Contact Form Handler
 *
 * Handles contact form submission and redirects to WhatsApp
 * Used in kontak.html page
 *
 * @version 1.0.0
 * @date 2025-11-19
 * @author arisciwek
 */

document.addEventListener('DOMContentLoaded', function() {
  const contactForm = document.getElementById('quickContactForm');

  if (!contactForm) {
    return;
  }

  contactForm.addEventListener('submit', function(e) {
    e.preventDefault();

    const name = document.getElementById('name').value;
    const phone = document.getElementById('phone').value;
    const productType = document.getElementById('productType').value;
    const quantity = document.getElementById('quantity').value;
    const city = document.getElementById('city').value;
    const message = document.getElementById('message').value;

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

    const encodedMessage = encodeURIComponent(whatsappMessage);

    // Get WhatsApp number from data attribute or global variable
    const whatsappNumber = contactForm.dataset.whatsapp || window.businessWhatsApp || '';
    const whatsappURL = `https://wa.me/${whatsappNumber}?text=${encodedMessage}`;

    window.open(whatsappURL, '_blank');
  });
});
