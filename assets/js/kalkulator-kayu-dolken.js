/**
 * ============================================================================
 * Kalkulator Kebutuhan Kayu Dolken
 * ============================================================================
 *
 * @file        kalkulator-kayu-dolken.js
 * @path        assets/js/kalkulator-kayu-dolken.js
 * @description Calculator functionality for dolken wood requirements
 * @version     1.0.0
 * @date        2025-11-21
 * @author      jualkayudolkengelam
 *
 * Features:
 * ---------
 * - Calculate number of dolken posts needed
 * - Form validation
 * - Display exact and rounded results
 * - Smooth scroll to result
 *
 * Formula:
 * --------
 * Number of posts = Total length (m) / Distance between posts (m)
 *
 * ============================================================================
 */

(function() {
  'use strict';

  const form = document.getElementById('calculator-form');
  const resultDiv = document.getElementById('calculator-result');
  const resultValue = document.getElementById('result-value');

  if (!form) return;

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    if (!form.checkValidity()) {
      e.stopPropagation();
      form.classList.add('was-validated');
      return;
    }

    // Get form values
    const formData = new FormData(form);
    const values = {};
    for (let [key, value] of formData.entries()) {
      values[key] = parseFloat(value) || 0;
    }

    // Calculate result
    try {
      // Calculate: panjang / jarak
      const result = values.panjang / values.jarak;
      const rounded = Math.ceil(result);

      // Display result with decimals
      resultValue.textContent = result.toLocaleString('id-ID', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 3
      }) + ' batang';

      // Display rounded result
      const roundedElement = document.getElementById('result-rounded');
      if (roundedElement) {
        roundedElement.textContent = rounded.toLocaleString('id-ID') + ' batang';
      }

      resultDiv.classList.remove('d-none');

      // Scroll to result
      resultDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    } catch (error) {
      console.error('Calculation error:', error);
      resultValue.textContent = 'Error dalam perhitungan';
      resultDiv.classList.remove('d-none');
    }
  });
})();
