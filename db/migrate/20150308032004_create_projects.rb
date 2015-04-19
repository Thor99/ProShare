class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :website
      t.string :video
      t.text :about
      t.string :facebook_page

      t.timestamps null: false
    end
  end
end
