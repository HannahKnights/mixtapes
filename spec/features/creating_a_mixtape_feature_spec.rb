require 'spec_helper'

describe "creating a mixtape" do 

  before do
    user=create(:user)
    login_as user, scope: :user
  end

  it "should display the new mixtape" do
    visit '/mixtapes/new'
    fill_in 'Title', with: "Love Beats"
    fill_in 'Track 1', with: "My Favourite Song"
    fill_in 'Track 2', with: "Another Favourite Song"
    click_button 'Create Mixtape'

    expect(current_path).to eq'/mixtapes'
    expect(current_path).to have_content 'Love Beats'
  end
  
end