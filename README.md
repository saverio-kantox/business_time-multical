`business_time-multical`
========================

Support several named calendars on all the `business_time` API.

You can add several holiday calendars, and then use them more simply with

```ruby
2.business_days('EUR', 'USD').from_now
Date.parse("2015-12-09").workday?('GBP')
# etc
```

The calendar storage is geared towards currencies, so three letters are
expected. You can also pass any nested array of strings, and even a concatenated
string:

```ruby
3.business_days('EURUSD').ago
```

The holidays that are considered when requesting multiple calendars like in
the above examples, are the union of each holiday calendar.

Loading calendars
-----------------

```ruby
BusinessTime::Config.load_calendars(
  'EUR' => [
    '2015-01-01', '2015-01-06', '2015-04-03', '2015-04-06',
    '2015-05-01', '2015-06-01', '2015-06-24', '2015-08-15',
    '2015-09-11', '2015-09-24', '2015-10-12', '2015-12-06',
    '2015-12-08', '2015-12-25', '2015-12-26'
  ],
  'JPY' => ['2015-01-01']
)
```

Other strategies to parse the requested set of calendars can be put in place.

A list of "default" calendars that are always applied can be set with:

```ruby
BusinessTime::Config.default_calendars = ["AAA", "BBB"]
```

Future
------

It would be better to split the calendar selection from the other methods, so
at some point we should migrate to

```ruby
BusinessTime.with_calendars('EUR', 'USD') { 2.business_days.from_now }
```


TODO
----

* Automatically run all tests from the `business_time` gem so we are sure we
  are not breaking anything

* Provide a better strategy to parse the requested calendars (maybe stop
  supporting concatenated calendar names)

