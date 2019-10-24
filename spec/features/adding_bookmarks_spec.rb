# frozen_string_literal: true

feature 'Adding a new bookmark' do
  scenario 'allows a user to add a bookmakr to bookmark manager' do
    visit '/new'
    fill_in('url', with: 'http://www.facebook.com')
    fill_in('title', with: 'Facebook')
    click_button 'Submit'

    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')
  end

  scenario 'the bookmark must be a valid url' do
    visit('/new')
    fill_in('url', with: 'not a real bookmark')
    fill_in('title', with: 'not a real bookmark')
    click_button('Submit')

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must enter a valid URL.'
  end
end
