class TicketsController < ApplicationController
  skip_before_action :require_login, only: [:new]
  def new
    @event = Event.find(params[:event_id])
  end

  def create

  end
end
