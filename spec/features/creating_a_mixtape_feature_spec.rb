require 'spec_helper'

describe "New Mixtape" do 


  context "creating a new mixtape" do

    it "should create a new mixtape" do
      visit '/'
      click_link 'Create Your Mixtape'

      expect(current_path).to eq new_mixtape_path
    end

  end

  context "Adding properties to the mixtape" do
    before do
      visit '/'
      click_link 'Create Your Mixtape'
    end

    it "should save a Mixtape Title" do
      fill_in 'Title', with: 'Awesome Mixtape'
      click_button 'RECORD TAPE'

      expect(page).to have_content 'Awesome Mixtape'
    end

    it "should allow tracks to be added to the mixtape" do
      fill_in 'Artist', with: 'Stevie Wonder'
      fill_in 'Song', with: 'Sir Duke'
      click_button 'Add Track to Mixtape'

      expect(page).to have_content 'Sir Duke'
    end

  end

  context "editing after logging in" do

      before do
        @user = create(:user)

        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:facebook] = {
          provider: 'facebook',
          uid: @user.uid,
          info: {
            email: @user.email,
            name: @user.name,
            location: @user.location,
            birthday: @user.birthday
          }
        }

        login_as @user

      end

    it 'should not display "Finish Mixing" button' do

      visit 'mixtapes/new'
      expect(page).not_to have_button 'Finish Mixing!'

    end


  end


  # it "should not allow a user to create more than one mixtape" do
  #   fill_in 'Title', with: "Love Beats"
  #   click_button 'Create Mixtape'
  #   visit '/mixtapes/new'

  #   expect(page).to have_content 'Only one mixtape allowed!'
  # end
  
end