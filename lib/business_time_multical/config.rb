module BusinessTimeMultical
  # A hash that allows to cache "union" of values
  class CalendarHash < Hash
    def [](key)
      return SortedSet.new if key.nil?
      return self[key.flatten.sort.join] if key.is_a?(Array)

      currencies = key.scan(/[\w™]{3}/).select(&method(:key?))
      self[key] = values_at(*currencies).inject(&:+) || SortedSet.new
    end

    def clean_cached(currency)
      delete_if { |k, _v| k.include?(currency) && k != currency }
    end
  end

  # Support loading currency holidays in BusinessTime
  module Config
    def load_holidays(holidays, container: config[:holidays], append: false)
      container.replace(SortedSet.new) unless append
      container.merge(holidays.map(&method(:parse_date)))
    end

    def load_currency_holidays(hash, append: false)
      config[:currency_holidays] ||= CalendarHash.new
      hash.each_with_object({}) do |(currency, holidays), memo|
        config[:currency_holidays].clean_cached(currency)
        container = config[:currency_holidays][currency]
        memo[currency] = \
          load_holidays(holidays, container: container, append: append)
      end
    end

    private

    def parse_date(date)
      if date.is_a?(Date)
        date
      else
        msg = <<-EOF.squish
        Provide holidays as `Date` objects instead of `#{holiday.class.name}`. I parsed that thing as #{holiday.to_date.inspect}"
        EOF
        warn(msg, caller.reject { |c| c =~ /#{__FILE__}/ })
        date.to_date
      end
    end

    def warn(msg, stack)
      ActiveSupport::Deprecation.warn(msg, stack)
    end
  end
end

BusinessTime::Config.class_eval do
  threadsafe_cattr_accessor :currency_holidays
  threadsafe_cattr_accessor :core_currencies
end

BusinessTime::Config::DEFAULT_CONFIG[:currency_holidays] = \
  BusinessTimeMultical::CalendarHash.new

BusinessTime::Config.extend(BusinessTimeMultical::Config)
