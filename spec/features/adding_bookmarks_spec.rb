# frozen_string_literal: true

feature 'Adding a new bookmark' do
  scenario 'allows a user to add a bookmakr to bookmark manager' do
    visit '/new'
    fill_in('url', with: 'http://www.facebook.com')
    fill_in('title', with: 'Facebook')
    click_button 'Submit'

    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')
  end
end
