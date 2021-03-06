require 'rails_helper'


RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = create(:user)
    visit "/"
    click_on "Login"
    expect(current_path).to eq('/login')
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on "Log In"
    expect(current_path).to eq('/profile')
    expect(page).to have_content("Logged in as #{user.name}")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Register")
    expect(page).to_not have_link("Login")
  end

  it "cannot log in with bad credentials" do
    user = create(:user)
    visit "/"
    click_on "Login"
    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"
    click_on "Log In"
    expect(current_path).to eq('/login')
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
