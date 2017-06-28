module BusinessTimeMultical
  # Support holiday calendars for Date calculations
  module DateExtensions
    def business_days_until(to_date, inclusive = false, *calendar_names)
      BusinessTimeMultical.with(calendar_names) { super(to_date, inclusive) }
    end

    def business_dates_until(to_date, inclusive = false, *calendar_names)
      BusinessTimeMultical.with(calendar_names) { super(to_date, inclusive) }
    end
  end
end
