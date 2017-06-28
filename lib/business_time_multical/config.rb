module BusinessTimeMultical
  # A hash that allows to cache "union" of values
  class CalendarHash < Hash
    def [](key)
      return SortedSet.new if key.blank?
      return self[key.flatten.sort.join] if key.is_a?(Array)

      names = key.scan(/[\w™]{3}/).select(&method(:key?))
      self[key] = values_at(*names).inject(&:+) || SortedSet.new
    end

    def clean_cached(name)
      delete_if { |k, _v| k.include?(name) && k != name }
    end
  end

  # Support loading currency holidays in BusinessTime
  module Config
    def load_calendars(hash, append: false)
      config[:calendars] ||= CalendarHash.new
      hash.each do |name, holidays|
        config[:calendars].clean_cached(name)
        container = config[:calendars][name]
        container.clear unless append
        container.merge(holidays.map(&method(:parse_date)))
      end
    end

    private

    def parse_date(date)
      return date if date.is_a?(Date)

      date.to_date.tap do |parsed|
        msg = <<-EOF.squish
        Provide holidays as `Date` objects instead of `#{date.class.name}`. I parsed that thing as #{parsed.inspect}"
        EOF
        ActiveSupport::Deprecation.warn(msg, caller(2))
      end
    end
  end
end

BusinessTime::Config.class_eval do
  threadsafe_cattr_accessor :calendars
  threadsafe_cattr_accessor :core_calendars
end

BusinessTime::Config::DEFAULT_CONFIG[:calendars] = \
  BusinessTimeMultical::CalendarHash.new

BusinessTime::Config.extend(BusinessTimeMultical::Config)
