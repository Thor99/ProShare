module ProjectsHelper
	def belongs_to_user(project)
		user_signed_in? && project.user == current_user
	end
end