# frozen_string_literal: true

require 'pg'

def persisted_data(table:, id:)
  DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
end

def create_new(url:, title:)
  Bookmark.create(url: url, title: title)
end

def create_new_bookmark_sql(url:, title:)
  DatabaseConnection.query(
    %{INSERT INTO bookmarks (url, title)
      VALUES('#{url}', '#{title}') RETURNING id, url, title}
  )
end

def standard_bookmarks
  create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
  create_new(url: 'http://www.twitter.com', title: 'Twitter')
  create_new(url: 'http://www.google.com', title: 'Google')
end
