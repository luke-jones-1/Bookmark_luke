feature 'Tags' do
  feature 'adding and viewing' do
    scenario 'a viewable tag is added to a bookmark' do
      bookmark = create_new(url: 'http://www.TestURL.com', title: 'Test Title')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Tag'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/new_tag"

      fill_in 'tag', with: 'Test Tag'
      click_button 'Submit'

      expect(current_path).to eq "/bookmarks"
      expect(first('.bookmark')).to have_content 'Test Tag'
    end
  end
end
