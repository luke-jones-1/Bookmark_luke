# frozen_string_literal: true

require_relative 'database_helpers'
require 'bookmark'

describe Bookmark do
  let(:comment_class) { double(:comment_class) }
  let(:tag_class) {double :tag_class}

  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = create_new(url: 'http://www.google.com', title: 'Google')
      create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      create_new(
        url: 'http://www.twitter.com', title: 'Twitter'
      )
      bookmarks = described_class.all
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a described_class
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'http://www.google.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark =
        create_new(url: 'http://www.facebook.com', title: 'Facebook')
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)
      expect(bookmark).to be_a described_class
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Facebook'
      expect(bookmark.url).to eq 'http://www.facebook.com'
    end

    it 'does not create a new bookmark if the url is not valid' do
      described_class.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(described_class.all).to be_empty
    end
  end
  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark =
        create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')

      described_class.delete(id: bookmark.id)

      expect(described_class.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark =
        create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark =
        described_class.update(
          id: bookmark.id,
          url: 'http://www.snakersacademy.com',
          title: 'Snakers Academy'
        )

      expect(updated_bookmark).to be_a described_class
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark =
        create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = described_class.find(id: bookmark.id)

      expect(result).to be_a described_class
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#comments' do
    it 'calls .where on comment class' do
      bookmark =
        create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end

  describe '#tags' do
    it 'calls .where on tag class' do
      bookmark =
        create_new(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      expect(tag_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.tags(tag_class)
    end
  end
end
