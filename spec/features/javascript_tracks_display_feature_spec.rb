require 'spec_helper'

describe 'creating, displaying and adding a track to a mixtape' do 
  
  it "should create a track with AJAX when I click create track" do
    visit '/mixtapes/new'
    fill_in 'Artist', with: 'BeeGees'
    click_button 'Add Track to Mixtape'

    expect(page).to have_content 'BeeGees' 
  end
  
end