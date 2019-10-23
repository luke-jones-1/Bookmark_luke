# frozen_string_literal: true

require 'database_helpers'

feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    create_new(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit('/bookmarks')

    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end
