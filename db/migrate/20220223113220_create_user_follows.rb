# frozen_string_literal: true

class CreateUserFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :user_follows do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :user_follows, :follower_id
    add_index :user_follows, :followed_id
    add_index :user_follows, %i[follower_id followed_id], unique: true
  end
end
