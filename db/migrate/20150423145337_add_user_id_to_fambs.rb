class AddUserIdToFambs < ActiveRecord::Migration
  def change
    add_reference :fambs, :user, index: true
    add_foreign_key :fambs, :users
  end
end
