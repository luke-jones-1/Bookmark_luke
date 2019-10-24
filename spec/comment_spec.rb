# frozen_string_literal: true

require_relative 'database_helpers'

require 'comment'

describe Comment do
  before(:each) do
    @result = create_new_bookmark_sql(url: 'http://www.TestURL.com', title: 'Test Title')
  end

  let(:bookmark) {double :bookmark, id: @result[0]['id'], url: @result[0]['url'], title: @result[0]['title']}

  describe '.create' do
    it 'creates a new comment' do
      comment = described_class.create(text: 'Test comment', bookmark_id: bookmark.id)
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comment).to be_a described_class
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the database' do
      described_class.create(text: 'Test comment', bookmark_id: bookmark.id)
      described_class.create(text: '2nd Test comment', bookmark_id: bookmark.id)

      comments = described_class.where(bookmark_id: bookmark.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end
