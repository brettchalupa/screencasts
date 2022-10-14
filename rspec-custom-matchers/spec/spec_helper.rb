RSpec.configure do |config|
  require_relative "support/json_helper"
  config.include JSONHelper

  require_relative "support/party_helper"
  config.include PartyHelper

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  config.profile_examples = 0

  config.order = :random

  Kernel.srand config.seed
end

RSpec::Matchers.define :have_key_with_value do |key, value|
  match do |hash|
    hash[key] == value
  end
end

RSpec::Matchers.define :contain_some_or_all do |*expected|
  match do |actual|
    expected.all? { |e| actual.include?(e) }
  end

  match_when_negated do |actual|
    expected.none? { |e| actual.include?(e) }
  end
end
