class AddStoryMainColmn < ActiveRecord::Migration
  def up
    add_column :stories, :is_main, :boolean, :default => false
    add_column :stories, :impressions_count, :integer
  end

  def down
    remove_column :stories, :main
  end
end
