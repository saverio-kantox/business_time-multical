require 'business_time'
require 'business_time_multical/business_days'
require 'business_time_multical/config'
require 'business_time_multical/core_ext'

# Support multicalendar holiday calculations
module BusinessTimeMultical
  def self.with?(calendars, &block)
    return block.call if calendars.empty?
    defaults = BusinessTime::Config.core_currencies
    holidays = BusinessTime::Config.currency_holidays[calendars] +
               BusinessTime::Config.currency_holidays[defaults]
    BusinessTime::Config.with(holidays: holidays) { block.call }
  end
end
