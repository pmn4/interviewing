# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'securerandom'

require File.expand_path '../checkout.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
