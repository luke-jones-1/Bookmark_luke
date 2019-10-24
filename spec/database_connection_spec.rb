# frozen_string_literal: true

require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a databasethrough PG' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')

      described_class.setup(dbname: 'bookmark_manager_test')
    end

    it 'this connection is persistent' do
      connection = described_class.setup(dbname: 'bookmark_manager_test')

      expect(described_class.connection).to eq connection
    end
  end
  describe '.query' do
    it 'executes a query via PG' do
      connection = described_class.setup(dbname: 'bookmark_manager_test')

      expect(connection).to receive(:exec).with('SELECT * FROM bookmarks;')

      described_class.query('SELECT * FROM bookmarks;')
    end
  end
end
