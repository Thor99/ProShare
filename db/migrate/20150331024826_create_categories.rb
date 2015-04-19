class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name_pt
      t.string :name_en

      t.timestamps null: false
    end
  end
end
