# frozen_string_literal: true

require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.query("SELECT * FROM bookmarks WHERE id = #{id};")
end

def create_new(url:, title:)
  Bookmark.create(url: url, title: title)
end

def standard_bookmarks
  create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
  create_new(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
  create_new(url: 'http://www.google.com', title: 'Google')
end
