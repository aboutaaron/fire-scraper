class FiresController < ApplicationController
	include ActionController::MimeResponds
  # GET /fires
  # GET /fires.json
  def index
    @fires = Fire.all
    
    respond_to do |format|
      format.json { render }
    end
  end
end