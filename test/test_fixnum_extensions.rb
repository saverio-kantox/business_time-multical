require_relative 'helper'

describe 'fixnum extensions' do
  before do
    BusinessTime::Config.load_calendars(
      'EUR' => [Date.civil(2015, 1, 12), Date.civil(2015, 5, 1)],
      'USD' => [Date.civil(2015, 5, 4)],
      'GBP' => [Date.civil(2015, 5, 5)]
    )
  end

  it 'respond to business_days by returning an instance of BusinessDays' do
    assert 1.business_day('EUR').instance_of?(BusinessTime::BusinessDays)
    assert 1.business_day('EUR', 'USD').instance_of?(BusinessTime::BusinessDays)
  end
end
