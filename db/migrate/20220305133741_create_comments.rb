# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :commentable, polymorphic: true

      t.timestamps
    end
    add_index :comments, %i[user_id created_at]
  end
end
