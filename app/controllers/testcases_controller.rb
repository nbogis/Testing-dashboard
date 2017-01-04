class TestcasesController < ApplicationController
  include TimeModule

  def show
    @testcase = Testcase.find(params[:id])
    @testsuite = @testcase.testsuite
    @protocol = @testsuite.protocol
    @product = @protocol.product

    active_record = @testcase.documentation
    if !active_record.nil?
      @documentation = active_record.body
    end

    active_record  = Testcase.get_keywords("setup",@testcase.id)
    if !active_record.empty?
      @setup = active_record.last.body
    end

    active_record  = Testcase.get_keywords("teardown", @testcase.id)
    if !active_record.empty?
      @teardown = active_record.last.body
    end

    @creator = Testcase.get_users("creator", @testcase.id)
    @modifiers  = Testcase.get_users("modifier", @testcase.id)

    @tag  = Testcase.get_tags("tag", @testcase.id)

    @result  = Testcase.result(@testcase.id).last.result

    @exec_time = TimeModule.get_time(@testcase.execution_time)

    @teststeps = Testcase.get_keywords("teststep", @testcase.id)
  end

end
