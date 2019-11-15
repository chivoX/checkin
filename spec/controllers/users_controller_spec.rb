# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  let(:admin) { create(:admin) }
  let(:token) { AuthenticateUser.new(admin.email, '123456789').call[:auth_token] }

  before(:each) do
    request.headers['Authorization'] = token
    request.headers['Accept'] = 'application/vnd.v1+json'
    create_list(:user_with_account, 3)
  end

  describe 'GET index' do
    it 'returns the correct types' do
      get :index
      expect_status '200'
      expect_json_types('data.*',
                        id: :string,
                        type: :string,
                        attributes: {
                          email: :string,
                          account: {
                            id: :integer,
                            first_name: :string,
                            last_name: :string,
                            gender: :string,
                            created_at: :date,
                            updated_at: :date
                          }
                        })
    end
  end

  describe 'GET index scoped queries' do
    let(:user) { create(:user_with_account) }
    it 'Retrieves users by first_name' do
      get :index, params: { by_first_name: user.account.first_name }
      expect_status '200'
      expect_json('data.*',
                        attributes: {
                          account: {
                            first_name: 'Test'
                          }
                        })
    end

    it 'Retrieves users by last name' do
      get :index, params: { by_last_name: user.account.last_name }
      expect_status '200'
      expect_json('data.*',
                        attributes: {
                          account: {
                            last_name: 'Tester'
                          }
                        })
    end

    it 'Retrieves users by email' do
      get :index, params: { by_email: user.email }
      expect_status '200'
      expect_json('data.*', attributes: { email: user.email })
    end

    it 'Retrieves users by gender' do
      get :index, params: { by_gender: user.account.gender }
      expect_status '200'
      expect_json('data.*',
                        attributes: {
                          account: {
                            gender: 'Male'
                          }
                        })
    end
  end


  describe 'POST create' do
    it 'creates a User' do
      post :create, params: {
        email: 'test@tester.com',
        password: '123456789',
        password_confirmation: '123456789',
        account_attributes: {
          first_name: 'pepe',
          last_name: 'locuaz',
          gender: 'male'
        }
      }
      expect_status '201'
      expect_json_types('data',
                        id: :string,
                        type: :string,
                        attributes: {
                          email: :string,
                          account: {
                            id: :integer,
                            first_name: :string,
                            last_name: :string,
                            gender: :string,
                            user_id: :integer,
                            created_at: :date,
                            updated_at: :date
                          }
                        })
    end

    it 'rejects an invalid request' do
      post :create, params: {
        email: 'invalid request'
      }
      expect_status '422'
      expect_json(message: "Validation failed: Password can't be blank, Email is invalid")
    end
  end

  describe 'PUT update' do
    it 'Update User' do
      put :update, params: {
        id: User.first,
        email: 'test@email.com',
        account_attributes: {
          first_name: 'new',
          last_name: 'name',
          gender: 'female'
        }
      }
      expect_status '200'
      expect_json_types('data',
                        id: :string,
                        type: :string,
                        attributes: {
                          email: :string,
                          account: {
                            id: :integer,
                            first_name: :string,
                            last_name: :string,
                            gender: :string,
                            user_id: :integer,
                            created_at: :date,
                            updated_at: :date
                          }
                        })
    end

    it 'Update  an unexistent Event' do
      delete :update, params: { id: 'invalid' }
      expect_status '404'
    end
  end

  describe 'GET show' do
    let(:user) { create(:user_with_account) }
    it 'Retrieves a User' do
      get :show, params: { id: user.id }
      expect_status '200'
      expect_json_types('data',
                        id: :string,
                        type: :string,
                        attributes: {
                          email: :string,
                          account: {
                            id: :integer,
                            first_name: :string,
                            last_name: :string,
                            gender: :string,
                            user_id: :integer,
                            created_at: :date,
                            updated_at: :date
                          }
                        })
    end

    it 'Retrieves an unexistent User' do
      get :show, params: { id: 'invalid' }
      expect_status '404'
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user_with_account) }
    it 'Deletes a User' do
      delete :destroy, params: { id: user.id }
      expect_status '200'
    end

    it 'Deletes an unexistent User' do
      delete :destroy, params: { id: 'invalid' }
      expect_status '404'
    end
  end
end
