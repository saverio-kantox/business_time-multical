module BusinessTimeMultical
  class CalendarHash < Hash
    def [](key)
      return SortedSet.new if key.nil?
      return self[key.flatten.sort.join] if Array === key

      currencies = key.scan(/[\w™]{3}/).select(&method(:key?))
      self[key] = values_at(*currencies).inject(&:+) || SortedSet.new
    end

    def clean_cached(currency)
      delete_if { |k, _v| k.include?(currency) && k != currency }
    end
  end

  module Config
    def load_holidays(holidays, container: config[:holidays], append: false)
      container.replace(SortedSet.new) unless append
      container.merge(holidays.map do |holiday|
        Date === holiday ? holiday : begin
          ActiveSupport::Deprecation.warn("Provide holidays as `Date` objects instead of `#{holiday.class.name}`. I parsed that thing as #{holiday.to_date.inspect}", caller.reject { |c| c =~ /#{__FILE__}/ })
          holiday.to_date
        end
      end)
    end

    def load_currency_holidays(hash, append: false)
      config[:currency_holidays] ||= CalendarHash.new
      hash.each_with_object({}) do |(currency, holidays), memo|
        config[:currency_holidays].clean_cached(currency)
        container = config[:currency_holidays][currency]
        memo[currency] = load_holidays(holidays, container: container, append: append)
      end
    end
  end
end

BusinessTime::Config.class_eval do
  threadsafe_cattr_accessor :currency_holidays
  threadsafe_cattr_accessor :core_currencies
end

BusinessTime::Config::DEFAULT_CONFIG[:currency_holidays] = BusinessTimeMultical::CalendarHash.new

BusinessTime::Config.extend(BusinessTimeMultical::Config)

puts 'Loaded business_time_multical/config.rb'
