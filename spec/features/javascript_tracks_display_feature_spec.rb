require 'spec_helper'

describe 'creating, displaying and adding a track to a mixtape' do 
  
  it "should create a track with AJAX when I click create track" do
    visit '/mixtapes/new'
    click_button 'Create Song'

    expect(page).to have_content 'artist' 
  end
  
end