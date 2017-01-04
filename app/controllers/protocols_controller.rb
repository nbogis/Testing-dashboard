class ProtocolsController < ApplicationController
  include ProtocolsHelper
  include TimeModule

  def index
    @protocols = Protocol.all
  end

  def new
    @protocol = Protocol.new
    @product = Product.find(params[:product_id])
    @document = @protocol.build_documentation
  end

  def create
    @protocol = Protocol.new(protocol_params)
    @protocol.product_id = params[:product_id]
    @product = Product.find(params[:product_id])
		if @protocol.save
        # @protocol.create_documentation(body: params[:documentation][:body])
        flash.notice = "A new protocol called '#{@protocol.name}' was created!"
        redirect_to product_path(@protocol.product)
    else
      # if fails save to db, go back to the same page
      redirect_to new_product_protocol_path(@protocol.product_id, @protocol)
    end
  end

  def edit
    @protocol = Protocol.find(params[:id])
    @document = @protocol.documentation
  end

  def update
    @protocol = Protocol.find(params[:id])

    if @protocol.update(protocol_params)
      # @protocol.documentation.update(body: params[:documentation][:body])
      flash.notice = "Protocol '#{@protocol.name}' was updated!"
  		redirect_to product_protocol_path(@protocol.product_id, @protocol) # or resdirect_to @test_suite
    else
      flash.notice = "Protocol '#{@protocol.name}' could not be updated!"
      render :edit
    end
  end

  def show
    @protocol = Protocol.find(params[:id])

    @attachment = Attachment.new
    @attachment.protocol_id = @protocol.id

    @executors = Protocol.get_users("executor", @protocol.id)
    @creator = Protocol.get_users("creator", @protocol.id)
    @modifiers = Protocol.get_users("modifier", @protocol.id)

    # get the testsuites results: [name, result, execution time]
    @prot_results = Protocol.exec_results(@protocol)

    # get the total execution time for the protocol
    @prot_time = Protocol.exec_time(@protocol)
  end

  def destroy
		@protocol = Protocol.find(params[:id])
    product_id = @protocol.product_id
    protocol_name = @protocol.name
		if @protocol.destroy
  		flash.notice = "Protocol '#{protocol_name}' was deleted!"
    else
      flash.notice = "Protocol cannot be deleted!"
    end

    redirect_to product_path(product_id) # or resdirect_to @product
  end

end
