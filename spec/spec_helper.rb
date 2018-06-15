require "bundler/setup"
require "test"
require 'checkout'
require 'item'
require 'promotional_rule'
require 'total_price_rule'
require 'multiple_items_rule'
require 'line_item'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  $LOAD_PATH << '../lib'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
