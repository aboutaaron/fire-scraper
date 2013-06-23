class FiresController < ApplicationController
  # GET /fires
  # GET /fires.json
  def index
    @county_fires = find_fires
    @fires = @county_fires.fires

    render json: @fires
  end

  def show
    @county_fires = find_fires
    @fires = @county_fires.fires.find(params[:id])
  end

  # http://railscasts.com/episodes/154-polymorphic-association?view=asciicast
  def find_fires
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end
