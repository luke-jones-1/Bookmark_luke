# frozen_string_literal: true

require 'pg'

# class for all bookmarks
class Bookmark
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = environment_connection.exec('SELECT * FROM bookmarks;')
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'], url: bookmark['url'], title: bookmark['title']
      )
    end
  end

  def self.create(url:, title:)
    result =
      environment_connection.exec(
        %{INSERT INTO bookmarks (url, title)
          VALUES('#{url}', '#{title}') RETURNING id, url, title}
      )
    create_object(result)
  end

  def self.delete(id:)
    environment_connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    result = environment_connection.exec(
      %(UPDATE bookmarks
        SET url = '#{url}', title = '#{title}'
        WHERE id = '#{id}'
        RETURNING id, url, title)
    )
    create_object(result)
  end

  def self.find(id:)
    result = environment_connection.exec(
      "SELECT * FROM bookmarks WHERE id = #{id};"
    )
    create_object(result)
  end

  def self.create_object(result)
    Bookmark.new(
      id: result[0]['id'], url: result[0]['url'], title: result[0]['title']
    )
  end

  def self.environment_connection
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
