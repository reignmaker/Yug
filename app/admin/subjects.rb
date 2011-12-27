ActiveAdmin.register Subject do
  index do
    column :title do |subject|
      link_to subject.title, admin_subject_path(subject)
    end
    column :description
    column :slug
    column "Stories", :stories_count, :sortable => false
  default_actions
  end
  show :title => :title do
      
  end
  
end
