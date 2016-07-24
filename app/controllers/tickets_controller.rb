class TicketsController < ApplicationController
  def new
    @type = Event.find(params[:event_id])
  end
end
