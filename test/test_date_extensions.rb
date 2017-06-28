require_relative 'helper'

describe 'date extensions' do
  before do
    BusinessTime::Config.load_calendars(
      'USD' => [Date.civil(2010, 4, 14)],
      'GBP' => [Date.civil(2010, 4, 15)]
    )
  end

  it 'currency holidays' do
    july_five = Date.parse('July 5, 2010')

    assert(july_five.workday?('USD'))

    BusinessTime::Config.load_calendars('USD' => [Date.civil(2010, 7, 5)])
    assert(!july_five.workday?('USD'))
    assert(july_five.workday?('EUR'))
  end

  it 'currency workdays' do
    assert(Date.parse('April 9, 2010').workday?('USD'))
    assert(Date.parse('April 9, 2010').workday?('USDEUR'))
    assert(Date.parse('April 9, 2010').workday?('USD', 'EUR'))
    assert(!Date.parse('April 14, 2010').workday?('USD'))
    assert(!Date.parse('April 14, 2010').workday?('USDEUR'))
    assert(!Date.parse('April 14, 2010').workday?('USD', 'EUR'))
  end
end
