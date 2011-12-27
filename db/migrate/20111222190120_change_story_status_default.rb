class ChangeStoryStatusDefault < ActiveRecord::Migration
  def up
    change_column :stories, :status, :string, :limit => 20, :default => 'moderating'
  end

  def down
  end
end
