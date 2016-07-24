class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @all_events = Event.published
    if params[:keyword]
      @events = @all_events.search(params[:keyword]).order(starts_at: :asc)
    else
      @events = @all_events.coming.order(starts_at: :asc)
    end

  end

  def publish
    @event = Event.find(params[:event_id])
    if @event.is_publish?
      flash[:success] = 'Unpublished event successfully!'
      @event.toggle_publish!
    else
      if @event.has_ticket_types?
        flash[:success] = 'Published event successfully!'
        @event.toggle_publish!
      else
        flash[:error] = 'Event doesn\'t have any ticket type!'
      end
    end
    redirect_to list_path
  end

  def list
    @events = Event.all.order(updated_at: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @venues = Venue.all
    @categories = Category.all
    @types = TicketType.all
  end

  def create
    @event = Event.new(event_params)
    @venues = Venue.all
    @categories = Category.all
    @event.author = current_user
    @event.publish = false
    if @event.save
      flash[:success] = 'Created event successfully!'
      redirect_to list_path
    else
      flash[:error] = "Error: #{@event.errors.full_messages.to_sentence}"
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    @venues = Venue.all
    @categories = Category.all
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'Updated event successfully!'
      redirect_to list_path
    else
      flash[:error] = "Error: #{@event.errors.full_messages.to_sentence}"
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = 'Deleted event successfully!'
      redirect_to list_path
    else
      flash[:error] = "Error: #{@event.errors.full_messages.to_sentence}"
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :venue_id, :category_id, :hero_image_url, :extended_html_description)
  end
end
