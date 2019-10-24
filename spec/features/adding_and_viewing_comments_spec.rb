# frozen_string_literal: true

feature 'Adding and viewing comments' do
  feature 'a comment is added to a bookmark' do
    scenario 'a comment is added to a bookmark' do
      bookmark =
        create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/new_comment"

      fill_in 'comment', with: 'This is a test comment'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'This is a test comment'
    end
  end
end
