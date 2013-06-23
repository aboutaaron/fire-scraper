class FiresController < ApplicationController
  # GET /fires
  # GET /fires.json
  def index
    @county_fires = find_fires
    @fires = @county_fires.fires

    render json: @fires
  end

  # This doesn't work well because Fire ids are created as fires are
  # Perhaps it's time to rewrite the scrapre
  def show
    @county_fires = find_fires
    @fires = @county_fires.fires.find(params[:id])

    render json: @fires
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
