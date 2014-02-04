require 'spec_helper'


describe 'click login via facebook' do

  before do
    user = create(:user)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      provider: 'facebook',
      uid: user.uid,
      info: {
        email: user.email
      }
    }
  end

  it 'should login a user' do

    visit '/users/sign_up'
    click_link 'Sign in with Facebook'

    page.should display_flash_message('Signed in successfully.')

  end

end

