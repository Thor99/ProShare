class Users::MyProjectsController < ApplicationController
	before_action :require_authentication, only: [:index]
	
	def index
		if params[:p].blank?
			@current_user_projects = current_user.projects.all.order("created_at DESC").page(params[:page]).per(6)
		else
			@search_mine = params[:p]
			my_projects_searched = current_user.projects.search(@search_mine)
			@current_user_projects = my_projects_searched.all.order("created_at DESC").page(params[:page]).per(6)
		end
	end
end