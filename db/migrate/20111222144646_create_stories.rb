class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :teaser, :limit => 400
      t.text :content
      t.string :status
      t.integer :user_id
      t.integer :subject_id
      t.datetime :published_at, :default => Time.now

      t.timestamps
    end
  end
end
