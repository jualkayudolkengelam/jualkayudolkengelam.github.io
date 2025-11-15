module Jekyll
  module CurrencyFilter
    def rupiah(input)
      # Convert to integer if needed
      value = input.to_i

      # Format with thousand separators (dots)
      value.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    end
  end
end

Liquid::Template.register_filter(Jekyll::CurrencyFilter)
