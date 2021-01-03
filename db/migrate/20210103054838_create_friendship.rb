class CreateFriendship < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :friend, class: 'User', index: true

      t.timestamps
    end
  end
end
