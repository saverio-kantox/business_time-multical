require 'business_time/business_days'

module BusinessTimeMultical
  module BusinessDays
    def initialize(days, *calendars)
      super(days)
      @calendars = calendars
    end

    private

    def calculate_after(time, days)
      BusinessTimeMultical.with?(@calendars) { super }
    end

    def calculate_before(time, days)
      BusinessTimeMultical.with?(@calendars) { super }
    end
  end
end

BusinessTime::BusinessDays.prepend BusinessTimeMultical::BusinessDays
