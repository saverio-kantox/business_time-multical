require 'business_time'
require 'business_time_multical/business_days'
require 'business_time_multical/config'
require 'business_time_multical/core_ext'

module BusinessTimeMultical
  def self.with?(calendars, &block)
    return block.call if calendars.empty?
    holidays = BusinessTime::Config.currency_holidays[calendars] +
               BusinessTime::Config.currency_holidays[BusinessTime::Config.core_currencies]
    BusinessTime::Config.with(holidays: holidays) { block.call }
  end
end
