# frozen_string_literal: true

require './lib/database_connection'

# p 'i got here'

if ENV['RACK_ENV'] == 'test'
  # p 'i got here'
  DatabaseConnection.setup(dbname: 'bookmark_manager_test')
else
  DatabaseConnection.setup(dbname: 'bookmark_manager')
end
