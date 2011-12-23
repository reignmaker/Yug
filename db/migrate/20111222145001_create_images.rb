class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :story_id
      t.integer :subject_id
      t.string :title
      t.string :file

      t.timestamps
    end
  end
end
