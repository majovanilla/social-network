# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  scenario 'Succesfully logs in/out an existing user' do
    User.create(username: 'John',
                email: 'john@example.com',
                password: 'password')
    visit login_path
    page.fill_in 'user_email', with: 'john@example.com'
    page.fill_in 'user_password', with: 'password'
    click_on(class: 'login')
    click_on 'Users'
    expect(page.current_path).to eq users_path
    click_on(class: 'friendship-button')
    # click_on(class: 'add-friend')
    have_content 'Friendship successfully sent'
  end
end
