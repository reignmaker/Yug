class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :description, :limit => 300
      t.string :slug

      t.timestamps
    end
  end
end
