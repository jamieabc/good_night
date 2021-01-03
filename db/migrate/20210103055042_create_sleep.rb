class CreateSleep < ActiveRecord::Migration[6.1]
  def change
    create_table :sleeps do |t|
      t.datetime :from, null: false
      t.datetime :to, null: false
      t.integer :duration, null: false, index: true

      t.belongs_to :user

      t.timestamps
    end
  end
end
