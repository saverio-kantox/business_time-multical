module BusinessTimeMultical
  module TimeExtensions
    def workday?(*calendars)
      BusinessTimeMultical.with?(calendars) { super() }
    end

    module ClassMethods
      %i[workday? roll_forward first_business_day roll_backward previous_business_day work_hours_total].each do |meth|
        define_method meth do |arg, *calendars|
          BusinessTimeMultical.with?(calendars) { super(arg) }
        end
      end
    end

    %i[business_time_until].each do |meth|
      define_method meth do |arg, *calendars|
        BusinessTimeMultical.with?(calendars) { super(arg) }
      end
    end

    %i[during_business_hours?].each do |meth|
      define_method meth do |*calendars|
        BusinessTimeMultical.with?(calendars) { super() }
      end
    end
  end
end
