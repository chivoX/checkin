module V1
  class UsersController < ApplicationController
    has_scope :by_name
    has_scope :by_last_name
    has_scope :by_email
    has_scope :by_gender

    before_action :admin?
    before_action :set_user, only: [:show, :update, :destroy]

    def index
      @users = user_account_query.paginate(page: params[:page])
      render json: UserSerializer.new(@users).serialized_json
    end

    def create
      user = User.create(user_params)
      json_response(user, :created)
    end

    def show
      json_response(@user, :ok)
    end

    def update
      @user.update!(user_params)
      json_response(@user)
    end

    def destroy
      @user.destroy
    end

    private

    def user_params
      params.permit(
	:email,
	:password,
	:password_confirmation,
	account_attributes: [
	  :name,
	  :last_name,
          :gender
	]
      )
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_account_query
      apply_scopes(User).all
    end
  end
end
