require 'spec_helper'

describe 'creating, displaying and adding a track to a mixtape' do 
  
  before do

    user = create(:user)
    login_as user, scope: :user
  
  end

  it "should create a track with AJAX when I click create track" do
    visit '/mixtapes/new'
    fill_in 'Artist', with: 'BeeGees'
    click_button 'Add Track to Mixtape'

    expect(page).to have_content 'BeeGees' 
  end
  
end