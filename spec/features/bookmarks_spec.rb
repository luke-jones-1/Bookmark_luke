# frozen_string_literal: true

require 'database_helpers'

feature 'Bookmark list' do
  scenario 'user can see list' do
    standard_bookmarks

    visit '/bookmarks'

    expect(page)
      .to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page)
      .to have_link('Twitter', href: 'http://www.twitter.com')
    expect(page)
      .to have_link('Google', href: 'http://www.google.com')
  end
end
