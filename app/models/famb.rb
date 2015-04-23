class Famb < ActiveRecord::Base
  belongs_to :project, counter_cache: true
  belongs_to :user
  validates_uniqueness_of :project_id, :user_id
end
