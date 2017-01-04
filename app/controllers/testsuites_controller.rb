class TestsuitesController < ApplicationController
  include TestsuitesHelper
  include TimeModule

  def index
    @testsuite = Testsuite.all
  end

  def new
    @testsuite = Testsuite.new
    @protocol = Protocol.find(params[:protocol_id])
    @document = @testsuite.build_documentation
  end

  def create
    @testsuite = Testsuite.new(testsuite_params)
    @testsuite.protocol_id = params[:protocol_id]
    product_id = @testsuite.protocol.product_id
		if @testsuite.save
        flash.notice = "A new testsuite called '#{@testsuite.name}' was created!"
        redirect_to product_protocol_path(product_id, @testsuite.protocol)
    else
      # if fails save to db, go back to the same page
      redirect_to new_product_protocol_testsuite_path(product_id, @testsuite.protocol, @testsuite)
    end
  end

  def edit
    @testsuite = Testsuite.find(params[:id])
    @document = @testsuite.documentation
  end

  def update
    @testsuite = Testsuite.find(params[:id])
    product_id = @testsuite.protocol.product_id
    if @testsuite.update(testsuite_params)
      flash.notice = "Testsuite '#{@testsuite.name}' was updated!"
  		redirect_to product_protocol_path(product_id, @testsuite.protocol)
    else
      flash.notice = "Testsuite '#{@testsuite.name}' could not be updated!"
      render :edit
    end
  end

  def show
    @testsuite = Testsuite.find(params[:id])

    # get setup and teardown
    @suite_setup = Testsuite.setup_keyword("suite setup", @testsuite.id).body if !@suite_setup.nil?
    @suite_teardown = Testsuite.setup_keyword("suite teardown", @testsuite.id).body if !@suite_teardown.nil?
    @test_setup = Testsuite.setup_keyword("test setup", @testsuite.id).body if !@test_setup.nil?
    @test_teardown = Testsuite.setup_keyword("test setup", @testsuite.id).body if !@test_teardowm.nil?

    # get setup tags
    @default_tag = Testsuite.get_tags("default tag", @testsuite.id)
    @force_tag = Testsuite.get_tags("force tag", @testsuite.id)

    # get users
    @executors = Testsuite.get_users("executor", @testsuite.id)
    @creator = Testsuite.get_users("creator", @testsuite.id)
    @modifiers = Testsuite.get_users("modifier", @testsuite.id)

    # get the testcases results: [name, result, execution time]
    @suite_results = Testsuite.exec_results(@testsuite.id)

    # add time in seconds to @suite_results and sum the seconds
    @suite_time = @suite_results.inject(0) do |sum, elem|
      second = TimeModule.convert_to_seconds(elem[2])
      elem.append(second)
      elem[2] = TimeModule.get_time(elem[2])
      sum += second
    end
    @suite_time = TimeModule.convert_to_time(@suite_time)
  end

  def destroy
		@testsuite = Testsuite.find(params[:id])
    protocol_id = @testsuite.protocol_id
    product_id = @testsuite.protocol.product_id
    testsuite_name = @testsuite.name
		if @testsuite.destroy
  		flash.notice = "Testsuite '#{testsuite_name}' was deleted!"
    else
      flash.notice = "Testsuite cannot be deleted!"
    end

    redirect_to product_protocol_path(product_id,protocol_id)
  end
end
