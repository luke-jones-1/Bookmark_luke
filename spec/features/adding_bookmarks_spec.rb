# frozen_string_literal: true

feature 'Adding a new bookmark' do
  it 'allows a user to add a bookmakr to bookmark manager' do
    visit '/new'
    fill_in('url', with: 'http://www.facebook.com')
    click_button 'Submit'

    expect(page).to have_content 'http://www.facebook.com'
  end
end
