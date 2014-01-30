class AddUserIdToReply < ActiveRecord::Migration
  def change
    add_column :replies, :user_id, :string
    change_column :posts, :postdescription,:string , :null => false
  end
end
