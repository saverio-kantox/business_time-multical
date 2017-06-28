require_relative 'helper'

describe 'time extensions' do
  before do
    BusinessTime::Config.load_calendars(
      'USD' => [Date.civil(2010, 4, 9)],
      'GBP' => [Date.civil(2010, 4, 12)]
    )
  end

  it 'currency workday' do
    assert(Time.parse('April 9, 2010 10:45 am').getlocal.workday?('GBP'))
    assert(!Time.parse('April 9, 2010 10:45 am').getlocal.workday?('USD'))
    assert(!Time.parse('April 9, 2010 10:45 am').getlocal.workday?('USDGBP'))
    assert(Time.parse('April 12, 2010 10:45 am').getlocal.workday?('USD'))
    assert(!Time.parse('April 12, 2010 10:45 am').getlocal.workday?('GBP'))
  end

  it 'know a weekend day is not a workday' do
    assert(Time.parse('April 12, 2010 10:45 am').getlocal.workday?('USD'))
    assert(!Time.parse('April 10, 2010 10:45 am').getlocal.workday?('GBPUSD'))
    assert(!Time.parse('April 11, 2010 10:45 am').getlocal.workday?('USDEUR'))
  end
end
