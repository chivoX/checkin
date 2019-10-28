require 'will_paginate/array'

module V1
  class ReportsController < ApplicationController
    before_action :admin?

    def index
      @results = fetch_report_data.paginate(page: params[:page])
      render json: ReportResultSerializer.new(@results).serialized_json
    end

    private

    def report_params
      params.permit(:amount)
    end

    def fetch_report_data
      ReportService.new(limit: report_params[:limit]).perform
    end
  end
end
