require 'rspec-api/responses'

module RSpecApi
  module Requests
    module Actions
      [:get, :put, :patch, :post, :delete].each do |action|
        define_method action do |route, options = {}, &block|
          options[:action] = action
          options[:route] = route
          options[:host] ||= rspec_api[:host] if rspec_api[:host]
          options[:authorize_with] ||= rspec_api[:authorize_with] if rspec_api[:authorize_with]
          RSpec::Core::ExampleGroup.describe "#{action.upcase} #{route}", options do
            extend Responses
            instance_eval &block if block
          end.register
        end
      end

      def rspec_api
        defined?(metadata) ? metadata : example.metadata
      end
    end
  end
end