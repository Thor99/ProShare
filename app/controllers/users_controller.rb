class UsersController < ApplicationController
	before_action :require_no_authentication, only: [:new, :create]
	before_action :can_change, only: [:edit, :update]

	def show
		@user = User.friendly.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user, notice: t('flash.notice.user_created')
		else
			render action: :new
		end
	end

	def edit
		@user = User.friendly.find(params[:id])
	end

	def update
		@user = User.friendly.find(params[:id])
		if @user.update(user_params)
			redirect_to @user, notice: t('flash.notice.user_updated')
		else
			render action: :edit
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :about, :password, :password_confirmation, :image)
	end

	def can_change
		unless user_signed_in? && current_user == user
			redirect_to user_path(params[:id])
		end
	end

	def user
		@user ||= User.friendly.find(params[:id])
	end
end