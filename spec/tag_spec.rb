# frozen_string_literal: true

require 'database_helpers'

describe Tag do

  let(:bookmark_class) { double :bookmark_class}

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
    context 'tag already exists' do
      it 'creates a new tag' do
        tag = described_class.create(content: 'Test Tag')

        persisted_data = persisted_data(table: 'tags', id: tag.id)

        expect(tag).to be_a described_class
        expect(tag.id).to eq persisted_data.first['id']
        expect(tag.content).to eq 'Test Tag'
      end
    end
    context 'tag already exists' do
      it 'returns already existing tag' do
        tag1 = described_class.create(content: 'Test Tag')
        tag2 = described_class.create(content: 'Test Tag')

        expect(tag2.id).to eq tag1.id
      end
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

  describe '.find' do
    it 'returns a tag with a given id' do
      tag = described_class.create(content: 'Test Tag')

      result = described_class.find(tag_id: tag.id)

      expect(result.id).to eq tag.id
      expect(result.content).to eq tag.content
    end
  end

  describe '#bookmarks' do
    it 'calls .where on bookmark class' do
      tag = described_class.create(content: 'Test Tag')

      expect(bookmark_class).to receive(:where).with(tag_id: tag.id)

      tag.bookmarks(bookmark_class)
    end
  end
end
