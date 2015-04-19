class AddAttachmentImageProjToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :image_proj
    end
  end

  def self.down
    remove_attachment :projects, :image_proj
  end
end
