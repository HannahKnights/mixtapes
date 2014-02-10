require "spec_helper"


  describe "Messaging" do

    before do
      @user_a = create(:user)
      @user_b = create(:jane)
    end

    context "Sending a message" do

      it "should be able to send a message" do
        login_as @user_a, scope: :user
        send_message

        expect(page).to have_content "Your message has been sent"
      end
    end

    context "Receiving a message" do
      before do
        login_as @user_a, scope: :user
        send_message
      end

      it "should put messages in the inbox" do
        login_as @user_b, scope: :user
        visit '/messages'
        expect(page).to have_content "Gary Oldman"
      end
    end

    context "Replying" do
      before do
        login_as @user_a, scope: :user
        send_message
      end

      it "should be able to reply to a message" do
        login_as @user_b, scope: :user
        visit '/messages'

        # within '.message' do
          click_link 'Reply'
        # end

        expect(find_field('Subject').value).to eq  "RE: I'm a test message"
      end

    end

  end

  def send_message
    visit '/messages/new'
    fill_in "Recipient", with: 'Jane Oldman'
    fill_in "Subject", with: "I'm a test message"
    fill_in "Body", with: "Lorem ipsum dollar whatevs"
    click_button "Send"
  end