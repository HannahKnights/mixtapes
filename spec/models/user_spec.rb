require 'spec_helper'

describe User do

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
      },
      extra: {
        raw_info: {
          birthday: @user.birthday,
          gender: 'male'
        }
      }
    }

    login_as @user

  end

  it 'should know age through birthday' do

    expect(@user.age).to eq 33
  
  end

  it 'should know their gender' do

    puts @user.name
    puts @user.male

    expect(@user.gender).to eq 'Male'

  end

end
