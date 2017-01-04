module TestsuitesHelper

  def testsuite_params
    params.require(:testsuite).permit(:name, documentation_attributes: [:body])
  end
end
