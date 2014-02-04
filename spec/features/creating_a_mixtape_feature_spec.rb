require 'spec_helper'

describe "creating a mixtape" do 

  before do
    user = create(:user)
    
    login_as user, scope: :user
  end

  it "should display the new mixtape" do
    visit '/mixtapes/new'
    fill_in 'Title', with: "Love Beats"
    
    click_button 'Create Mixtape'

    expect(page).to have_content 'Love Beats'
  end
  
end