class FiresController < ApplicationController
  # GET /fires
  # GET /fires.json
  def index
    @fires = Fire.all
    
    respond_to do |format|
      format.json { render }
    end
  end