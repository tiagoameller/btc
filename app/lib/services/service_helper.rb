module Services
  module ServiceHelper
    def parse_date(value, default)
      (value.present? ? Date.parse(value) : default)
    rescue ArgumentError => e
      errors.add e.message
    end
  end
end
