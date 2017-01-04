require "rails_helper"

describe ProtocolsController do
  describe "protocol controllers" do
    let(:product) { create(:product)}
    let(:protocol) {create(:protocol, :product_id => product.id)}
    let(:user) { create(:user) }

    before do
      product
    end

    it "renders the :new template when user is logged in" do
      user_sign_in
      get :new, :product_id => product.id
      expect(response).to render_template :new
    end

    it "doesn't render :new template when user is not logged in" do
      get :new, :product_id => product.id
      expect(flash[:notice]).to eq("sorry, you need to sign in")
      expect(response).to redirect_to(products_path)
    end

    describe "POST #create" do
      it "redirect to the new protocol" do
        user_sign_in
        post :create, :protocol => attributes_for(:protocol), :product_id => product.id

        expect(response).to redirect_to product_path(protocol.product)
      end

      it "actually creates the protocol" do
        expect {post :create, protocol: attributes_for(:protocol), :product_id => product.id}.to change(Protocol, :count).by(1)
      end
    end

    describe "GET #show" do
      it "renders the :show template" do
        get :show, :id => protocol.id, :product_id => product.id
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      it "renders :edit template when user is logged in" do
        user_sign_in
        get :edit, :id => protocol.id, :product_id => product.id

        expect(response).to render_template :edit
      end

      it "doesn't render :edit template when user is logged out" do
        get :edit, :id => protocol.id, :product_id => product.id

      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        let(:updated_name) {"protocol_spec_1"}
        before do
          put :update, :id => protocol.id, :product_id => product.id,
                        :protocol => attributes_for(:protocol,:name => updated_name)
        end
        it "finds the specified protocol" do
          expect(assigns(:protocol)).to eq(protocol)
        end

        it "redirect to the updated protocol" do
          expect(response).to redirect_to product_protocol_path(protocol.product_id,protocol)
        end

        it "actually updates the protocol" do
          protocol.reload
          expect(protocol.name).to eq(updated_name)
        end

        it "show flash message after updating correctly" do
          protocol.reload
          expect(flash[:notice]).to eq("Protocol '#{protocol.name}' was updated!")
        end
      end
    end

    describe "Delete #destroy" do
      # force let to evaluate
      before do
        protocol
      end

      it "destroys the protocol" do
        expect {delete :destroy, :id => protocol.id, :product_id => product.id}.to change(Protocol, :count).by(-1)
      end

      it "redirects back to the root" do
        delete :destroy, :id => protocol.id, :product_id => product.id
        expect(response).to redirect_to product_path(protocol.product_id)
      end

      it "show flash message after destroying correctly" do
        delete :destroy, :id => protocol.id, :product_id => product.id
        expect(flash[:notice]).to eq("Protocol '#{protocol.name}' was deleted!")
      end
    end
  end
end
