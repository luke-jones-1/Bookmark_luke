# frozen_string_literal: true

require_relative 'database_helpers'
require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = create_new(url: 'http://www.google.com', title: 'Google')
      create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      create_new(
        url: 'http://www.destroyallsoftware.com', title: 'Destroy All software'
      )
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'http://www.google.com'
    end
  end
  describe '.create' do
    it 'creates a new bookmark' do
      bookmark =
        create_new(url: 'http://www.facebook.com', title: 'Facebook')
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Facebook'
      expect(bookmark.url).to eq 'http://www.facebook.com'
    end
  end
  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end
  describe '.update' do
    it 'updates a bookmark' do
      bookmark = create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end
  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end
end
