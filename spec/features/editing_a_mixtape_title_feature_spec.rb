require 'spec_helper'

describe 'editing a mixtape' do

  before do
    mixtape = create(:mixtape)
    visit '/mixtapes'
    click_button 'Edit Mixtape'
  end

  context "Title" do

    it 'should have a pre-filled Title field' do
      expect(find_field('Title').value).to eq "My Awesome Mixtape"
    end

    it 'should allow a title to be changed' do
      fill_in 'Title', with: "A Great New Name"
      click_button "Save Changes"

      expect(page).to have_content 'A Great New Name'
    end
  end

  context "Tracks" do

    it 'should have existing tracks' do
      expect(page).to have_content "Sir Duke"
    end

    it 'should allow a track to be deleted' do
      click_link "Delete"
      expect(page).to_not have_content "Sir Duke"
    end

    it 'should allow a track to be added' do
      fill_in 'Artist', with: 'BeeGees'
      fill_in 'Song', with: 'How Deep Is Your Love'
      click_button 'Add Track to Mixtape'

      expect(page).to have_content 'BeeGees'
    end
    
  end

end