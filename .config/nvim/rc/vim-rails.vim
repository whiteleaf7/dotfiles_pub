let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_request_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_request_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \  "app/controllers/concerns/*.rb": {
      \      "test": [
      \        "spec/requests/concerns/{}_spec.rb",
      \        "test/controllers/concerns/{}_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/concerns/{}_spec.rb",
      \        "spec/controllers/concerns/{}_spec.rb",
      \        "test/controllers/concerns/{}_test.rb"
      \      ],
      \   },
      \  "app/commands/*.rb": {
      \      "test": [
      \        "spec/commands/{}_spec.rb",
      \      ],
      \      "alternate": [
      \        "spec/commands/{}_spec.rb",
      \      ],
      \   },
      \   "spec/requests/*_request_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "spec/requests/concerns/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/concerns/{}.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "spec/domains/*_spec.rb": {
      \      "command": "domain",
      \      "alternate": "app/domains/{}.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "spec/commands/*_spec.rb": {
      \      "command": "commands",
      \      "alternate": "app/commands/{}.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \ }
