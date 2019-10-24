# frozen_string_literal: true

require 'bookmark_tag'

describe BookmarkTag do
  before(:each) do
    @bm_result = create_new_bookmark_sql(url: 'http://www.TestURL.com', title: 'Test Title')
    @t_result = create_new_tag_sql(content: 'Test Tag')
  end

  let (:bookmark) {double :bookmark, id: @bm_result[0]['id'], url: @bm_result[0]['url'], title: @bm_result[0]['title']}
  let (:tag) {double :tag, id: @t_result[0]['id'], content: @t_result[0]['content']}
  describe '.create' do
    it 'creates a link between a given bookmark and tag' do
      bookmark_tag = described_class.create(bookmark_id: bookmark.id, tag_id: tag.id)

      expect(bookmark_tag).to be_a BookmarkTag
      expect(bookmark_tag.tag_id).to eq tag.id
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
    end
  end
end
