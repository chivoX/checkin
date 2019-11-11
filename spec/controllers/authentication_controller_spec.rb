# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user_with_account) }

  describe 'POST authenticate' do
    it 'Authenticates a User' do
      post :authenticate, params: {
        email: user.email,
        password: '123456789'
      }
      expect_status '200'
      expect_json_types(
        auth_token: :string,
        user_type: :string,
        user_name: :string,
        user_id: :integer
      )
    end
  end
end
