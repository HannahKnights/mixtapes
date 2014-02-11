require "spec_helper"



  describe "Conversation" do

    before do
      @user_a = create(:user)
      @user_b = create(:jane)
    end

    context "Grouping interactions" do
      before do
        login_as @user_a, scope: :user
        send_message
      end
      
      it "should display the latest user with whom an interaction has occured" do
        login_as @user_b, scope: :user
        visit "/messages"

        expect(page).to have_content 'Gary Oldman' 
      end
    end
  end

def send_message
    visit '/messages/new'
    fill_in "Recipient", with: 'Jane Oldman'
    fill_in "Body", with: "Lorem ipsum dollar whatevs"
    click_button "Send"
  end