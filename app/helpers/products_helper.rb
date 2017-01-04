module ProductsHelper

  def product_params
    params.require(:product).permit(:name, :dhf_num)
  end
end
