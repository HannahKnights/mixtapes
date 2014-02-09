require 'spec_helper'


describe 'logging in' do

  before do
    user = create(:user)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      provider: 'facebook',
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name,
        location: user.location
      }
    }
  end

  it 'a user can log in via Facebook' do

    visit '/'
    click_link 'Create Your Mixtape'
    click_link 'FINISH MIXING!'
    expect('Signed in successfully.')

  end

end
