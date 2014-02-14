require 'spec_helper'

describe 'Mixtape tracks' do

  before do
    @mixtape = create :mixtape
    @user = create :user, mixtape_id: 1
  end

  context 'Typing the first letter of an artist\'s name should', js: true do

    it 'display a list of 5 matching artists' do
      login_as @user, scope: :user
      puts @mixtape.inspect
      visit '/mixtapes/1/tracks/new'
      # raise page.html
      fill_in 'track_artist', with: 'Coldpl'
      expect(page).to have_content 'Coldplay'
    end
  end
end