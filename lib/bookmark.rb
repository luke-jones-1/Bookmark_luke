# frozen_string_literal: true

require 'pg'

# class for all bookmarks
class Bookmark
  def self.all
    connection = environment
    result = connection.exec('SELECT * FROM bookmarks;')
    result.map { |bookmark| bookmark['url'] }
  end

  def self.create(url:)
    connection = environment
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}');")
  end

  def self.environment
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
