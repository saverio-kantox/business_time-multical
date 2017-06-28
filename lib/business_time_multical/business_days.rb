require 'business_time/business_days'

module BusinessTimeMultical
  # Support calendars to BusinessDays class
  module BusinessDays
    def initialize(days, *calendar_names)
      super(days)
      @calendar_names = calendar_names
    end

    private

    def calculate_after(time, days)
      BusinessTimeMultical.with(@calendar_names) { super }
    end

    def calculate_before(time, days)
      BusinessTimeMultical.with(@calendar_names) { super }
    end
  end
end

BusinessTime::BusinessDays.prepend BusinessTimeMultical::BusinessDays
