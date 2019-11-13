# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::EventsController, type: :controller do
  let(:user) { create(:user_with_account) }
  let(:token) { AuthenticateUser.new(user.email, '123456789').call[:auth_token] }

  before(:each) do
    request.headers['Authorization'] = token
    request.headers['Accept'] = 'application/vnd.v1+json'
  end

  describe 'GET index' do
    it 'returns the correct types' do
      get :index
      expect_json_types('data.*',
                        id: :string,
                        type: :string,
                        attributes: {
                          checkin: :date,
                          checkout: :date,
                          total_worked_hours: :integer
                        })
    end
  end

  describe 'POST create' do
    it 'creates an Event' do
      post :create, params: {
        checkin: Time.now,
        checkout: Time.now + 10.hours,
        user_id: user.id
      }
      expect_status '201'
      expect_json_types('data',
                        type: :string,
                        attributes: {
                          checkin: :date,
                          checkout: :date,
                          total_worked_hours: :integer
                        })
    end
  end

  describe 'GET show' do
    let(:event) { create(:event) }
    it 'Retrieves an Event' do
      get :show, params: { id: event.id }
      expect_status '200'
      expect_json_types('data',
                        type: :string,
                        attributes: {
                          checkin: :date,
                          checkout: :date,
                          total_worked_hours: :integer
                        })
    end

    it 'Retrieves an unexistent Event' do
      get :show, params: { id: 'invalid' }
      expect_status '404'
    end
  end

  describe 'PUT update' do
    let(:event) { create(:event) }
    it 'Update Event' do
      put :update, params: { checkout: Time.now + 10.hours, id: event.id }
      expect_status '200'
      expect_json_types('data',
                        type: :string,
                        attributes: {
                          checkin: :date,
                          checkout: :date,
                          total_worked_hours: :integer
                        })
    end
  end


  describe 'DELETE destroy' do
    let(:event) { create(:event) }
    it 'Deletes an Event' do
      delete :destroy, params: { id: event.id }
      expect_status '200'
    end

    it 'Deletes an unexistent Event' do
      delete :destroy, params: { id: 'invalid' }
      expect_status '404'
    end
  end
end
