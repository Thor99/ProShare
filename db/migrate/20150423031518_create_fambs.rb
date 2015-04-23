class CreateFambs < ActiveRecord::Migration
  def change
    create_table :fambs do |t|
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :fambs, :projects
  end
end
