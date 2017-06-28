module BusinessTimeMultical
  # Support holiday calendars for Time calculations
  module TimeExtensions
    def workday?(*calendar_names)
      BusinessTimeMultical.with(calendar_names) { super() }
    end

    # Support holiday calendars for Time calculations
    module ClassMethods
      %i[workday? roll_forward first_business_day roll_backward
         previous_business_day work_hours_total].each do |meth|
        define_method meth do |arg, *calendar_names|
          BusinessTimeMultical.with(calendar_names) { super(arg) }
        end
      end
    end

    %i[business_time_until].each do |meth|
      define_method meth do |arg, *calendar_names|
        BusinessTimeMultical.with(calendar_names) { super(arg) }
      end
    end

    %i[during_business_hours?].each do |meth|
      define_method meth do |*calendar_names|
        BusinessTimeMultical.with(calendar_names) { super() }
      end
    end
  end
end
