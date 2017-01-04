module ProtocolsHelper

  def protocol_params
		params.require(:protocol).permit(:name, :revision, documentation_attributes: [:body])
	end
end
