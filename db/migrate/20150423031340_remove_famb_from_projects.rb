class RemoveFambFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :famb, :integer
  end
end
