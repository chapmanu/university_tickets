# Helpers for file paths
SPEC_ROOT = File.dirname(__file__)
SAMPLES   = File.join(SPEC_ROOT, 'samples')

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.warnings = true

  # Documentation format when only running one file
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # Show top 10 slowest test
  config.profile_examples = 10

   # Ordering of tests
  config.order = :random
  Kernel.srand config.seed

end
