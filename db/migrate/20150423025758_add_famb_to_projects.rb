class AddFambToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :famb, :integer, :default => 0
  end
end
