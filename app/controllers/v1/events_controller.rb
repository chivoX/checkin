# frozen_string_literal: true

module V1
  class EventsController < ApplicationController
    before_action :set_event, only: %i[show update destroy]

    def index
      @events = event_query.paginate(page: params[:page])
      render json: EventSerializer.new(@events).serialized_json
    end

    def create
      event = Event.create!(event_params)
      json_response(event, :created)
    end

    def show
      json_response(@event, :ok)
    end

    def update
      @event.update!(event_params)
      json_response(@event)
    end

    def destroy
      @event.destroy
      head :ok
    end

    private

    def event_params
      params.permit(:checkin, :checkout, :user_id)
    end

    def event_query
      current_user.is_a?(Admin) ? Event.all : Event.where(user: current_user)
    end

    def set_event
      @event = Event.find(params[:id])
    end
  end
end
