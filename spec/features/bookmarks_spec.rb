# frozen_string_literal: true

feature 'Bookmark list' do
  scenario 'user can see list' do
    visit '/bookmarks'

    expect(page).to have_content 'http://www.makersacademy.com'
    expect(page).to have_content 'http://www.destroyallsoftware.com'
    expect(page).to have_content 'http://www.google.com'
  end
end
