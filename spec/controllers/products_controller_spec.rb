require "rails_helper"

describe ProductsController do
  describe "product controllers" do
    let(:product) {create(:product)}

    describe "GET #index" do
      it "collects products into @products" do
        another_product = create(:product)
        get :index

        expect(assigns(:products)).to match_array [product, another_product]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end

    describe "POST #create" do
      it "redirect to the new product" do
        post :create, :product => attributes_for(:product)

        expect(response).to redirect_to product_path(assigns(:product))
      end

      it "actually creates the product" do
        expect {post :create, product: attributes_for(:product)}.to change(Product, :count).by(1)
      end
    end

    describe "GET #show" do
      it "renders the :show template" do
        get :show, :id => product.id
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      it "renders :edit template" do
        get :edit, :id => product.id

        expect(response).to render_template :edit
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        let(:updated_name) {"product_spec_1"}

        it "finds the specified product" do
          put :update, :id => product.id,
                        :product => attributes_for(:product,:name => updated_name)
          expect(assigns(:product)).to eq(product)
        end

        it "redirect to the updated product" do
          put :update, :id => product.id,
                        :product => attributes_for(:product,:name => updated_name)
          expect(response).to redirect_to product_path(assigns(:product))
        end

        it "actually updates the product" do
          put :update, :id => product.id,
                        :product => attributes_for(:product,:name => updated_name)
          product.reload
          expect(product.name).to eq(updated_name)
        end
      end
    end

    describe "Delete #destroy" do
      # force let to evaluate
      before {product}

      it "destroys the product" do
        expect {delete :destroy, :id => product.id}.to change(Product, :count).by(-1)
      end

      it "redirects back to the root" do
        delete :destroy, :id => product.id
        expect(response).to redirect_to products_path()
      end
    end
  end
end
