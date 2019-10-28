module V1
  class EventsController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    def index
      @events = event_query.paginate(page: params[:page])
      render json: EventSerializer.new(@events).serialized_json
    end

    def create
      event = Event.create(user_params)
      json_response(event, :created)
    end

    def show
      json_response(@event, :ok)
    end

    def update
      @event.update!(event_params)
      json_response(@user)
    end

    def destroy
      @event.destroy
    end

    private

    def event_params
      params.permit(:checkin, :checkout)
    end

    def event_query
      current_user.kind_of?(Admin) ? Event.all : Event.where(user: current_user)
    end

    def set_event
      @event = Event.find(params[:id])
    end
  end
end
