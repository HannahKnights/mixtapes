require 'spec_helper'

describe "creating a mixtape" do 

  before do
    user = create(:user)
    
    login_as user, scope: :user
    visit '/mixtapes/new'
  end

  it "should display the new mixtape" do
    fill_in 'Title', with: "Love Beats"
  
    click_button 'Create Mixtape'

    expect(page).to have_content 'Love Beats'
  end

  # it "should not allow a user to create more than one mixtape" do
  #   fill_in 'Title', with: "Love Beats"
  #   click_button 'Create Mixtape'
  #   visit '/mixtapes/new'

  #   expect(page).to have_content 'Only one mixtape allowed!'
  # end
  
end