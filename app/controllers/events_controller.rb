class EventsController < ApplicationController
  def index
    if params[:keyword]
      # @events = Event.coming.search(params[:keyword])
      @events = Event.search(params[:keyword])
    else
      @events = Event.coming
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
