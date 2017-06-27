require 'minitest/autorun'
require 'minitest/rg'
require "minitest/reporters"

if ENV["COV"]
  require 'simplecov'
  SimpleCov.start
end

require 'thread'
require 'time'
require 'date'
require 'active_support/time'

require 'byebug'

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'business_time_multical'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::ProgressReporter.new]

MiniTest::Spec.class_eval do
  after do
    BusinessTime::Config.send(:reset)
    Time.zone = nil
  end
end
