class AddFambsCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :fambs_count, :integer, :default => 0
  end
end
