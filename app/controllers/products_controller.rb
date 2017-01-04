class ProductsController < ApplicationController
  include ProductsHelper
  include TimeModule

  def index
    @products = Product.all

    @products_results = {}
    passed = 0
    failed = 0
    disabled = 0
    @products.each do |prod|
      result = Product.exec_results(prod)
      count = result.each do |res|
        if res.include? "Pass"
          passed += 1
        elsif res.include? "Fail"
          failed +=1
        else
          disabled += 1
        end
      end
      @products_results[prod.id] = {"name" => prod.name, "Pass" => passed,"Fail" => failed, "Disabled" => disabled}
    end
  end

  def show
    @product = Product.find(params[:id])
    @protocols = @product.protocols

    # get product final result
    @result = Product.result(@product)

    # get protocols results: [name, result, execution time]
    @prod_results = Product.exec_results(@product)

    # get the total execution time for the product
    @prod_time = Product.exec_time(@product)

  end

  def new
    @product = Product.new
  end

  def create
    @product= Product.new(product_params)
    if @product.save
      flash.notice = "A new product called '#{@product.name}' was created!"
      # if save to db succeeded, go to show passing all the parameters in @product
      redirect_to @product # or resdirect_to @product
    else
      # if fails save to db, go back to the same page
      flash.notice = "Something went wrong. Please refil the form"
      redirect_to new_product_path
    end
  end

  def destroy
		# create a variable mapped to product with id passed from previous page
		@product = Product.find(params[:id])
		@product.destroy

		flash.notice = "Product '#{@product.name}' was deleted!"
		redirect_to products_path # or resdirect_to @product
	end

	def edit
		# create a variable mapped to product with id passed from previous page
		@product = Product.find(params[:id])
	end

	def update
		# create a variable mapped to product with id passed from previous page
		@product = Product.find(params[:id])
		@product.update(product_params)

		flash.notice = "Product '#{@product.name}' was updated!"
		redirect_to product_path(@product)
	end
end
