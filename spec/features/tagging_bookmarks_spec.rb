# frozen_string_literal: true

feature 'Tags' do
  feature 'adding and viewing' do
    scenario 'a viewable tag is added to a bookmark' do
      bookmark = create_new(url: 'http://www.TestURL.com', title: 'Test Title')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Tag'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/new_tag"

      fill_in 'tag', with: 'Test Tag'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Test Tag'
    end
  end

  feature 'a user can filter bookmarks by tags' do
    scenario 'adding the same tag to multiple bookmarks then filterinmg the' do
      create_new(url: 'http://www.TestURL1.com', title: 'Test Title 1')
      create_new(url: 'http://www.TestURL2.com', title: 'Test Title 2')
      create_new(url: 'http://www.TestURL2.com', title: 'Test Title 3')

      visit '/bookmarks'

      first('.bookmark').click_button 'Add Tag'
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      within page.find('.bookmark:nth-of-type(2)') do
        click_button 'Add Tag'
      end
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      first('.bookmark').click_link 'testing'

      expect(page).to have_link 'Test Title 1', href: 'http://www.TestURL1.com'
      expect(page).to have_link 'Test Title 2',  href: 'http://www.TestURL2.com'
      expect(page).not_to have_link 'Test Title 3', href: 'http://www.TestURL3.com'
    end
  end
end
