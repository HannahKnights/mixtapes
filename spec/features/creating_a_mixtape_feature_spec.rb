require 'spec_helper'

describe "New Mixtape" do 


  context "creating a new mixtape" do

    it "should create a new mixtape" do
      visit '/'
      click_button 'Create Your Mixtape'
      expect(current_path).to eq new_mixtape_path
    end

  end

  context "Adding properties to the mixtape" do
    
    before do
      visit '/'
      click_button 'Create Your Mixtape'
    end

    it "should save a Mixtape Title" do
      
      fill_in 'Title', with: 'Awesome Mixtape'
      click_button 'Edit Mixtape Title'
      visit new_mixtape_path
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

    visit '/'
    
    click_button 'Create Your Mixtape'

    @test_users = Koala::Facebook::TestUsers.new(:app_id => Rails.application.secrets.facebook_key, :secret => Rails.application.secrets.facebook_secret)
    access_token =  @test_users.list.first["access_token"]

    @user = build(:user)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      provider: 'facebook',
      uid: @user.uid,
      info: {
        email: @user.email,
        name: @user.name,
        location: @user.location,
        name: @user.name
      },
      extra: {
        raw_info: {
          birthday: @user.birthday,
          gender: @user.male
        }
      },
      credentials: {
        token: access_token
      }
    }

    @user = User.find_for_facebook_oauth(Hashie::Mash.new(OmniAuth.config.mock_auth[:facebook]))
    
    login_as @user

    visit '/'

  end

    it 'should not display "Finish Mixing" button' do

      click_link 'Edit my Mixtape'
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