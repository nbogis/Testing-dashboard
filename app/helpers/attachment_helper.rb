module AttachmentHelper
  def attachment_params
    params.require(:attachment).permit(:attach)
  end
end
