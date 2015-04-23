class User < ActiveRecord::Base
	extend FriendlyId

	has_many :projects, dependent: :destroy
	has_many :upvoted_projects, through: :fambs, source: :project
	
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	scope :confirmed, -> { where.not(created_at: nil) }

	validates_presence_of :name, :email, :about, :slug

	validates_length_of :about, :minimum => 15
	validates_length_of :password, :minimum => 5

	validates_uniqueness_of :email

	validates_format_of :email, with: EMAIL_REGEXP

	has_secure_password

	has_attached_file :image, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>" }
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  	friendly_id :name, use: [:slugged, :history]

  	def self.authenticate(email, password)
  		user = confirmed.find_by(email: email)
  		if user.present?
  			user.authenticate(password)
  		end
  	end

  	def should_generate_new_friendly_id?
  		slug.blank? || name_changed?
	end
end
