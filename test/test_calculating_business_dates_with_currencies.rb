require_relative 'helper'

describe 'calculating business dates' do
  before do
    BusinessTime::Config.load_calendars(
      'USD' => [Date.civil(2010, 12, 27)]
    )
  end

  it 'properly calculate business dates over weekends plus extra holiday' do
    friday = Date.parse('December 24, 2010')
    tuesday = Date.parse('December 28, 2010')
    assert_equal [friday], friday.business_dates_until(tuesday, false, 'USD')
    assert_equal [friday], friday.business_dates_until(tuesday, false, 'USDEUR')
    assert_equal [friday],
                 friday.business_dates_until(tuesday, false, 'USD', 'EUR')
  end
end
