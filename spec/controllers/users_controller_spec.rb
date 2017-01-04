require 'rails_helper'

describe UsersController do
  describe "user access" do
    let(:user) { create(:user) }
    let(:users) { [user, create(:user)] }

    describe 'PUT #update' do
      let(:put_update_valid) do
          put :update,
              id: user.id,
              user: {
                  profile_pic_id: photo.id
              }
      end

      let(:put_update_invalid) do
          put :update,
              id: user.id,
              user: {
                  first_name: '',
                  last_name: '',
                  email: '',
                  password: '',
                  password_confirmation: ''
              }
      end

      let(:photo) { user.profile_pic.create }

      before do
        create_user_session(user)
        photo
      end

      context "when data is valid" do
        before do
          put_update_valid
          user.reload
        end

        it "updates the user" do
          expect(user.profile_pic_id).to eq(photo.id)
        end

        it "redirect to the user" do
          expect(response).to redirect_to :user
        end

        it "sets a success flash" do
          expect(flash[:notice]).to eq("Your profile was successfully updated!")
        end
      end

      context "when data is invalid" do
        before do
          put_update_invalid
        end

        it "does not update the user" do
          expect(user.profile_pic).to be_nil
        end

        it "redirect edit profile template" do
          expect(response).to redirect_to user_edit_path(user)
        end

        it "sets a failure flash" do
          expect(flash[:notice]).to eq("Your profile failed to update!")
        end
      end
    end
  end



end
