require 'spec_helper'

describe 'editing a mixtape' do

  before do

    user = create(:user)
    login_as user, scope: :user

    @mixtape = create(:mixtape)
  end

  it "should let a user edit their own mixtape" do
    visit '/mixtapes'
    click_button 'Edit Title'
    fill_in 'Title', with: 'A new title'
    click_button 'Save Changes'

    expect(page).to have_content "A new title"
  end


end