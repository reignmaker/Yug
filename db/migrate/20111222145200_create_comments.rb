class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :story_id
      t.text :text, limit: 500

      t.timestamps
    end
  end
end
