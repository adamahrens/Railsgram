# frozen_string_literal: true

Kaminari.configure do |config|
  config.default_per_page = 3
  config.max_per_page = 3
  config.params_on_first_page = true
end
