class Project < ActiveRecord::Base
	extend FriendlyId
	belongs_to :user
	belongs_to :category
	has_many :fambs, dependent: :destroy

	FACEBOOK_REGEX = /\A(https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
	VIDEO_REGEX = /\A(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
	URL_REGEX =  /\A((http|https):\/\/)(([a-z0-9-\.]*)\.)?([a-z0-9-]+)\.([a-z]{2,5})(:[0-9]{1,5})?(\/)?/

	validates_presence_of :name, :about, :slug

	validates_uniqueness_of :name

	validates_format_of :video, with: VIDEO_REGEX, allow_blank: true
	validates_format_of :facebook_page, with: FACEBOOK_REGEX, allow_blank: true
	validates_format_of :website, with: URL_REGEX, allow_blank: true

	has_attached_file :image_proj, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>" }
  	validates_attachment_content_type :image_proj, :content_type => /\Aimage\/.*\Z/

  	friendly_id :name, use: [:slugged, :history]

	validates_length_of :about, minimum: 15

	def should_generate_new_friendly_id?
  		slug.blank? || name_changed?
	end

	def self.search(query)
		if query.present?
			where(['name LIKE :query or about LIKE :query', query: "%#{query}%"])
		else
			all
		end
	end
end
