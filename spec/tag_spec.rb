# frozen_string_literal: true

require 'database_helpers'

describe Tag do
  before(:each) do
    @bm_result =
      create_new_bookmark_sql(
        url: 'http://www.TestURL.com',
        title: 'Test Title'
      )
  end

  let(:bookmark) do
    double :bookmark,
    id: @bm_result[0]['id'],
    url: @bm_result[0]['url'],
    title: @bm_result[0]['title']
  end

  describe '.create' do
    it 'creates a new tag' do
      tag = described_class.create(content: 'Test Tag')

      persisted_data = persisted_data(table: 'tags', id: tag.id)

      expect(tag).to be_a described_class
      expect(tag.id).to eq persisted_data.first['id']
      expect(tag.content).to eq 'Test Tag'
    end
  end

  describe '.where' do
    it 'returns tags linked to the given bookmark id' do
      tag1 = described_class.create(content: 'Test Tag 1')
      tag2 = described_class.create(content: 'Test Tag 2')
      create_new_bookmark_tag_sql(bookmark_id: bookmark.id, tag_id: tag1.id)
      create_new_bookmark_tag_sql(bookmark_id: bookmark.id, tag_id: tag2.id)

      tags = described_class.where(bookmark_id: bookmark.id)
      tag = tags.first

      expect(tags.length).to eq 2
      expect(tag).to be_a described_class
      expect(tag.id).to eq tag1.id
      expect(tag.content).to eq tag1.content
    end
  end
end
