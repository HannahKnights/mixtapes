require 'spec_helper'




describe 'editing my profile page' do

  before do

    @user = create(:user)

    # OmniAuth.config.test_mode = true
    # OmniAuth.config.mock_auth[:facebook] = {
    #   provider: 'facebook',
    #   uid: @user.uid,
    #   info: {
    #     email: @user.email,
    #     name: @user.name,
    #     location: @user.location,
    #     name: @user.name
    #   },
    #   credentials: {
    #     auth_token: @user.auth_token
    #   }
    # }

    login_as @user

    visit '/users/edit'

  end

  context 'changing profile data' do

    it 'a user can update their name' do

      expect(@user.name).to eq 'Joe Bloggs'
      fill_in 'Name', with: 'John Smith'
      click_button 'Update'
      expect(@user.reload.name).to eq 'John Smith'

    end

    it 'a user can update their name' do

      expect(@user.email).to eq 'test@test.com'
      fill_in 'Email', with: 'fake@fake.com'
      click_button 'Update' 
      expect(@user.reload.email).to eq 'fake@fake.com'

    end

    it 'a user can update their location' do

      expect(@user.location).to eq 'London, United Kingdom'
      fill_in 'Location', with: 'Sheffield, United Kingdom'
      click_button 'Update' 
      expect(@user.reload.location).to eq 'Sheffield, United Kingdom'

    end

    it 'a user can update their picture' do

      expect(@user.image_url).to eq ''
      click_button 'Change Picture'
      click_button 'Update' 
      expect(@user.reload.image_url).to eq 'new'

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