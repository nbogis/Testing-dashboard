require "rails_helper"

describe AttachmentsController do
  describe "attachment controllers" do
    let(:product) { create(:product)}
    let(:protocol) { create(:protocol, :product_id => product.id)}
    let(:attachment) { create(:attachment, :protocol_id => protocol.id)}

    before do
      product
      protocol
    end

    describe "POST #create" do
      it "redirect to the new attachment" do
        post :create, :attachment => attributes_for(:attachment), :protocol_id => protocol.id, :product_id => product.id

        expect(response).to redirect_to product_protocol_path(product,protocol)
      end

      it "actually creates the attachment" do
        expect {post :create, attachment: attributes_for(:attachment), :protocol_id => protocol.id, :product_id => product.id}.to change(Attachment, :count).by(1)
      end
    end

    describe "Delete #destroy" do
      # force let to evaluate
      before do
        attachment
      end

      it "destroys the attachment" do
        expect {delete :destroy, :id => attachment.id, :protocol_id => protocol.id, :product_id => product.id}.to change(Attachment, :count).by(-1)
      end

      it "redirects back to the protocol page" do
        delete :destroy, :id => attachment.id, :protocol_id => protocol.id, :product_id => product.id
        expect(response).to redirect_to product_protocol_path(attachment.protocol.product_id, attachment.protocol_id)
      end

      it "show flash message after destroying correctly" do
        file_name = attachment.attach_file_name
        delete :destroy, :id => attachment.id, :protocol_id => protocol.id, :product_id => product.id
        expect(flash[:notice]).to eq("Attachment '#{file_name}' was deleted!")
      end
    end
  end
end
