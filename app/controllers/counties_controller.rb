class CountiesController < ApplicationController
  # GET /counties
  # GET /counties.json
  def index
    @counties = County.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @counties }
    end
  end

  # GET /counties/1
  # GET /counties/1.json
  def show
    @county = County.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @county }
    end
  end

  # GET /counties/new
  # GET /counties/new.json
  def new
    @county = County.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @county }
    end
  end

  # GET /counties/1/edit
  def edit
    @county = County.find(params[:id])
  end

  # POST /counties
  # POST /counties.json
  def create
    @county = County.new(params[:county])

    respond_to do |format|
      if @county.save
        format.html { redirect_to @county, notice: 'County was successfully created.' }
        format.json { render json: @county, status: :created, location: @county }
      else
        format.html { render action: "new" }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /counties/1
  # PUT /counties/1.json
  def update
    @county = County.find(params[:id])

    respond_to do |format|
      if @county.update_attributes(params[:county])
        format.html { redirect_to @county, notice: 'County was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counties/1
  # DELETE /counties/1.json
  def destroy
    @county = County.find(params[:id])
    @county.destroy

    respond_to do |format|
      format.html { redirect_to counties_url }
      format.json { head :no_content }
    end
  end
end
