require 'spec_helper'
require 'hashie'



describe 'editing my profile page' do

  before do
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
          # gender: 'male'
        }
      },
      credentials: {
        token: access_token
      }
    }

    @user = User.find_for_facebook_oauth(Hashie::Mash.new(OmniAuth.config.mock_auth[:facebook]))
    login_as @user

    puts @user
    puts @user.name

    click_link 'Edit my Profile'

  end

  context 'changing profile data' do

    it 'a user can update their name' do

      expect(@user.name).to eq 'Gary Oldman'
      fill_in 'Name', with: 'Gary Newman'
      click_button 'Update'
      expect(@user.reload.name).to eq 'Gary Newman'

    end

    it 'a user can update their email address' do

      expect(@user.email).to eq 'gary_ggqwrri_oldman@tfbnw.net'
      fill_in 'Email', with: 'gary_oldman@tfbnw.net'
      click_button 'Update' 
      expect(@user.reload.email).to eq 'gary_oldman@tfbnw.net'

    end

    it 'a user can update their location' do

      expect(@user.location).to eq 'London, United Kingdom'
      fill_in 'Location', with: 'Sheffield, United Kingdom'
      click_button 'Update' 
      expect(@user.reload.location).to eq 'Sheffield, United Kingdom'

    end

    it 'a user has a profile picture' do

      within(:css, '.profile-pictures-container') { expect(page).to have_css 'img.profile-picture' }

    end


  end

  context 'deleting my profile' do

    it 'should be able to remove an account' do
      expect(User.count).to eq 1
      click_button 'Cancel my account'
      expect(User.count).to eq 0

    end

  end

end