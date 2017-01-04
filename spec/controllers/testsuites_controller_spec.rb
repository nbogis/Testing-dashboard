require "rails_helper"

describe TestsuitesController do
  describe "testsuite controllers" do
    let(:product) { create(:product)}
    let(:protocol) {create(:protocol, :product_id => product.id)}
    let(:testsuite) { create(:testsuite, :protocol_id => protocol.id, :product_id => product.id)}
    let(:user) { create(:user) }

    before do
      product
      protocol
    end

    it "renders the :new template" do
      get :new, :protocol_id => protocol.id, :product_id => product.id
      expect(response).to render_template :new
    end

    describe "POST #create" do
      it "redirect to the new testsuite" do
        post :create, :testsuite => attributes_for(:testsuite), :protocol_id => protocol.id, :product_id => product.id

        expect(response).to redirect_to product_protocol_path(product, protocol)
      end

      it "actually creates the testsuite" do
        expect { post :create, :testsuite => attributes_for(:testsuite), :protocol_id => protocol.id, :product_id => product.id }.to change(Testsuite, :count).by(1)
      end
    end

    describe "GET #show " do
      it "renders the :show template" do
        get :show, :id => testsuite.id, :protocol_id => protocol.id, protocol.product_id => product.id
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      it "renders :edit template when user is logged in" do
        get :edit, :id => testsuite.id, :protocol_id => protocol.id, :product_id => product.id

        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        let(:updated_name) {"protocol_spec_1"}
        before do
          put :update, :id => testsuite.id, :protocol_id => protocol.id, :product_id => product.id,
                        :testsuite => attributes_for(:testsuite,:name => updated_name)
        end
        it "finds the specified testsuite" do
          expect(assigns(:testsuite)).to eq(testsuite)
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
