# frozen_string_literal: true

require 'swagger_helper'

describe 'Events API' do

  path '/events' do

    get 'All events' do
      tags 'Events'
      produces 'application/json', 'application/vnd.checkin.v1+json'
      security [Bearer: {}]

      response '200', 'list of events' do
        let(:user) {create(:user_with_account)}
        let(:Authorization) { "#{auth_headers(user)}" }

        schema type: :object,
          properties:  {
          data: {
            type: :array,
            items:  {
              type: :object,
              properties: {
                id: {type: :string},
                checkin: {type: :string}
              }
            }
          }
        },
        required: %i[checkin]

        run_test!
      end
    end
  end
end
