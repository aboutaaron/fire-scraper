class CountiesController < ApplicationController
  # Allow Rails respond_to to work
  include ActionController::MimeResponds

  # GET /counties
  # GET /counties.json
  def index
    @counties = County.all

    respond_to do |format|
      format.json { render }
    end
  end

  # GET /counties/1
  # GET /counties/1.json
  def show
    @county = County.find(params[:id])

    respond_to do |format|
      format.json { render }
    end
  end
end
