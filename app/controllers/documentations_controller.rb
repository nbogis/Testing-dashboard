class DocumentationsController < ApplicationController
  include DocumentationsHelper

  def index
		@documents = Documentation.all
	end

end
