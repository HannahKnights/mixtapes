require 'spec_helper'

describe 'users can "like" each others mixtape' do

  before do
    
    mixtape = create(:mixtape)
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
    
    visit '/'
    click_button 'Create Your Mixtape'
    click_link 'FINISH MIXING!'
  
  end

  context 'browsing the matches page' do

    it 'a user can "like" another user' do

      visit '/mixtapes'
      first('.like').click_button('i_like_you')

    end

  end

end