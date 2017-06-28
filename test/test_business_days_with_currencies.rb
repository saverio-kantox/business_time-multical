require_relative 'helper'

describe 'business days with currencies' do
  before do
    BusinessTime::Config.load_calendars(
      'EUR' => [Date.civil(2015, 1, 12), Date.civil(2015, 5, 1)],
      'USD' => [Date.civil(2015, 5, 4)],
      'GBP' => [Date.civil(2015, 5, 5)]
    )
  end

  describe 'with a standard Time object' do
    it 'should move to monday if we add a business day to April, 30' do
      first = Time.parse('April 30th, 2015, 11:00 am').getlocal
      later = 1.business_day('EUR').after(first)
      expected = Time.parse('May 4th, 2015, 11:00 am').getlocal
      assert_equal expected, later
    end

    it 'should move to Tuesday as first business day after April 30 USD/EUR' do
      first = Time.parse('April 30th, 2015, 11:00 am').getlocal
      later = [1.business_day('EURUSD').after(first),
               1.business_day('USDEUR').after(first),
               1.business_day('EUR|USD').after(first),
               1.business_day('USD|EUR').after(first),
               1.business_day('USD', 'EUR').after(first),
               1.business_day('USD', 'EUR', 'USD').after(first),
               1.business_day('EUR', 'USD').after(first),
               1.business_day('EUR', 'USD').after(first),
               1.business_day('USD', 'EUR', 'PLN').after(first),
               1.business_day('PLN', 'USD', 'EUR').after(first)]
      expected = Time.parse('May 5th, 2015, 11:00 am').getlocal
      later.each do |l|
        assert_equal expected, l
      end
    end

    it 'moves to Wednesday from April 30 USD/EUR/GBP' do
      first = Time.parse('April 30th, 2015, 11:00 am').getlocal
      later = 1.business_day('USD', 'GBP', 'EUR').after(first)
      expected = Time.parse('May 6th, 2015, 11:00 am').getlocal
      assert_equal expected, later
    end

    it 'moves to Friday as first business day after April 30 USD' do
      first = Time.parse('April 30th, 2015, 11:00 am').getlocal
      later = 1.business_day('USD').after(first)
      expected = Time.parse('May 1st, 2015, 11:00 am').getlocal
      assert_equal expected, later
    end
  end
end
