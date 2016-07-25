class TicketsController < ApplicationController
  skip_before_action :require_login, only: [:new]

  def new
    @event = Event.find(params[:event_id])
    unless @event.is_coming?
      flash[:error] = 'Event finished! Booking is unavailable!'
    end
  end

  def create

  end
end
