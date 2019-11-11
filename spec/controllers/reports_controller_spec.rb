# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ReportsController, type: :controller do
  let(:user) { create(:admin) }
  let(:token) { AuthenticateUser.new(user.email, '123456789').call[:auth_token] }
  let(:limit) { 2 }

  before(:each) do
    request.headers['Authorization'] = token
    request.headers['Accept'] = 'application/vnd.v1+json'
    create_list(:user_with_account, 20)
  end

  describe 'GET index' do
    it 'Return results with the correct types' do
      get :index
      expect_json_types('data.*',
                        id: :string,
                        type: :string,
                        attributes: {
                          email: :string,
                          total_worked_hours: :integer
                        })
    end

    it 'Returns an specific amount of results' do
      get 'index', params: { limit: limit }
      expect_json(data: ->(data) { expect(data.size).to eq(2) })
    end
  end
end
