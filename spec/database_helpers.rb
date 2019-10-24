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

def create_new_tag_sql(content:)
  DatabaseConnection.query(
    %{INSERT INTO tags (content)
    VALUES('#{content}') RETURNING id, content}
  )
end

def create_new_bookmark_tag_sql(bookmark_id:, tag_id:)
  DatabaseConnection.query(
    %{INSERT INTO bookmarks_tags (bookmark_id, tag_id)
      VALUES('#{bookmark_id}', '#{tag_id}') RETURNING bookmark_id, tag_id}
  )
end
