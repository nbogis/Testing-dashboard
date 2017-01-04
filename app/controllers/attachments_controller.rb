class AttachmentsController < ApplicationController
  include AttachmentHelper

  def index
    @attachments = Attachment.order('created_at')
  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.protocol_id = params[:protocol_id]
    if @attachment.save
      flash[:notice] = "File was added!"
    else
      flash[:notice] = "Something went wrong!! Make sure to select a txt, html, or xml file"
    end
    # go back to the show page
    redirect_to product_protocol_path(@attachment.protocol.product_id,@attachment.protocol_id)
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    prot_id = @attachment.protocol_id
    prod_id = @attachment.protocol.product_id
    file_name = @attachment.attach_file_name
    @attachment.destroy

    flash.notice = "Attachment '#{file_name}' was deleted!"
    redirect_to product_protocol_path(prod_id,prot_id)
  end

  # additional non-crud methods to serve file
  # inline disposition, the browser will try to open the file within the browser
  def serve_inline
    @attachment = Attachment.find(params[:id])
    send_data(@attachment.file_contents,:filename => "#{@attachment.attach_file_name}",:type => @attachment.attach_content_type,:disposition => "inline")
  end

  # attachment disposition, it allows the user to download the file from the browser
  def serve_attach
    @attachment = Attachment.find(params[:id])
    send_data(@attachment.file_contents,:filename => "#{@attachment.attach_file_name}",:type => @attachment.attach_content_type,:disposition => "attachment")
  end

end
