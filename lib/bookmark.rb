# frozen_string_literal: true

require 'uri'
require_relative 'database_connection'
require_relative 'comment'

# class for all bookmarks
class Bookmark
  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |bookmark|
      Bookmark.new(
        id: bookmark['id'], url: bookmark['url'], title: bookmark['title']
      )
    end
  end

  def self.create(url:, title:)
    return false unless url?(url)

    result =
      DatabaseConnection.query(
        %{INSERT INTO bookmarks (url, title)
          VALUES('#{url}', '#{title}') RETURNING id, url, title}
      )
    create_object(result)
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    return false unless url?(url)

    result = DatabaseConnection.query(
      %(UPDATE bookmarks
        SET url = '#{url}', title = '#{title}'
        WHERE id = '#{id}'
        RETURNING id, url, title)
    )
    create_object(result)
  end

  def self.find(id:)
    result = DatabaseConnection.query(
      "SELECT * FROM bookmarks WHERE id = #{id};"
    )
    create_object(result)
  end

  def self.create_object(result)
    Bookmark.new(
      id: result[0]['id'], url: result[0]['url'], title: result[0]['title']
    )
  end

  class << self
    private

    def url?(url)
      url =~ /\A#{URI.regexp(['http', 'https'])}\z/
    end
  end

  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @title = title
    @url = url
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end
end
