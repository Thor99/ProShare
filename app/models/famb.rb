class Famb < ActiveRecord::Base
  belongs_to :project, counter_cache: true
end
