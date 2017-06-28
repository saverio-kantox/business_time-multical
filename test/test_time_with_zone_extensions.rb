require_relative 'helper'

describe 'TimeWithZone extensions' do
  describe 'With Eastern Standard Time' do
    before do
      Time.zone = 'Eastern Time (US & Canada)'
      BusinessTime::Config.load_calendars(
        'USD' => [Date.civil(2010, 4, 9)],
        'GBP' => [Date.civil(2010, 4, 12)]
      )
    end

    it 'currency workday' do
      assert(Time.zone.parse('April 9, 2010 10:45 am').workday?('GBP'))
      assert(!Time.zone.parse('April 9, 2010 10:45 am').workday?('USD'))
      assert(!Time.zone.parse('April 9, 2010 10:45 am').workday?('USDGBP'))
      assert(!Time.zone.parse('April 9, 2010 10:45 am').workday?('USD', 'GBP'))
      assert(Time.zone.parse('April 12, 2010 10:45 am').workday?('USD'))
      assert(!Time.zone.parse('April 12, 2010 10:45 am').workday?('GBP'))
    end

    it 'know a weekend day is not a workday' do
      assert(Time.zone.parse('April 12, 2010 10:45 am').workday?('USD'))
      assert(!Time.zone.parse('April 10, 2010 10:45 am').workday?('GBPUSD'))
      assert(!Time.zone.parse('April 11, 2010 10:45 am').workday?('USD', 'EUR'))
    end
  end
end
