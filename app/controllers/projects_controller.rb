class ProjectsController < ApplicationController
	before_action :require_authentication, only: [:new, :create, :edit, :update, :upvote]
	before_action :set_users_projects, only: [:edit, :update, :destroy]
	
	

	def index
		if params[:q].blank? && params[:category].blank?

			@projects = Project.all.order("fambs_count DESC").page(params[:page]).per(6)

		elsif params[:q].present? && params[:category].blank?

			@search = params[:q]
			projects_searched = Project.search(@search)
			@projects = projects_searched.all.order('fambs_count DESC').page(params[:page]).per(6)

		elsif params[:q].blank? && params[:category].present?

			@category_id = Category.find_by(name_en: params[:category]).id
			@projects = Project.where(category_id: @category_id).order("fambs_count DESC").page(params[:page]).per(6)

		elsif params[:q].present? && params[:category].present?

			@category_id = Category.find_by(name_en: params[:category]).id
			@search = params[:q]
			projects_with_category = Project.where(category_id: @category_id).order("fambs_count DESC")
			projects_searched_with_category = projects_with_category.search(@search)
			@projects = projects_with_category.all.order('fambs_count DESC').page(params[:page]).per(6)

		end
	end

	def show
		@project = Project.friendly.find(params[:id])
		@code = @project.video.split('=');
		@yt_code = @code[1]
	end

	def new
		@project = current_user.projects.build
	end

	def create
		@project = current_user.projects.build(project_params)

		if @project.save
			redirect_to @project, notice: t('flash.notice.project_created')
		else
			render action: :new
		end
	end

	def edit
		
	end

	def update
		
		if @project.update(project_params)
			redirect_to @project, notice: t('flash.notice.project_updated')
		else
			render action: :edit
		end
	end

	def destroy
		@project.destroy
		redirect_to root_path, notice: t('flash.notice.project_destroyed')
	end

	def upvote
		@project = Project.friendly.find(params[:id])
		
	    if @project.fambs.create(user_id: current_user.id) && @project.fambs_count_changed?
			redirect_to @project
	    else
	    	redirect_to @project, alert: t('flash.alert.already_fambed')
	    end
	    
	end

	private

	def project_params
		params.require(:project).permit(:name, :about, :facebook_page, :video, :website, :image_proj, :category_id, :famb)
	end

	def set_users_projects
		@project = current_user.projects.friendly.find(params[:id])
	end
end