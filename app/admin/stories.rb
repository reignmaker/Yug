ActiveAdmin.register Story do
scope :all, :default => true
scope :main do |stories|
  stories.where(:is_main => true)
end
scope :published do |stories|
  stories.where(:status => Story::STATUS_PUBLISHED)
end
scope :moderating do |stories|
  stories.where(:status => Story::STATUS_MODERATING)
end
scope :approved do |stories|
  stories.where(:status => Story::STATUS_APPROVED)
end
scope :unapproved do |stories|
  stories.where(:status => Story::STATUS_UNAPPROVED)
end
scope :deleted do |stories|
  stories.where(:status => Story::STATUS_DELETED)
end

# controller do
#   def create
#     story = params[:story]
#     subject = Subject.find_or_create_by_title(story[:subject_title])
#     story.delete(:subject_title)
#     @story = Story.new(story)
#     @story.subject_id = subject.id
#     if @story.save
#       render action: "show"
#     else
#       render action: "new"
#     end
#   end

#   def update
#     subject = Subject.find_or_create_by_title(params[:story][:subject_title])
#     params[:story].delete(:subject_title)
#     @story = Story.find(params[:id])
#     @story.subject_id = subject.id

#     if @story.update_attributes(params[:story])
#       render action: "show"
#     else
#       render action: "new"
#     end
#   end
# end

  index do
    column :title do |story|
      link_to story.title.truncate(40), admin_story_path(story)
    end
    column :content do |story|
      story.content.truncate(30)
    end
    column :status do |story|
      status_tag story.status, story.status_tag
    end
    column :published_at
    column "Page Views", :impressions_count
    default_actions
  end

  show :title => :title do
    panel "Story" do
    attributes_table_for story do
      #binding.pry
      row ("Subject") {link_to story.subject_title, admin_subject_path(story.subject_id)}
      row ("Title") {story.title}
      row ("Teaser") {story.teaser.html_safe}
      row ("Content") {story.content.html_safe}

    end
  end
  end

  form do |f|
    f.inputs do
      if f.object.new_record? then
        f.object.build_subject
        f.input :subject_id, :collection =>Subject.all, :as => :select
      else
        f.input :subject_id, :collection =>Subject.find(params[:id]), :as => :select
      end
      f.input :subject_id, :collection =>Subject.all, :as => :select #:as => :autocomplete, :url => "/admin/subjects/autocomplete_subject_title"
      f.input :title
      f.input :teaser
      f.input :content
      f.input :status, :collection => Story.status_collection, :as => :radio
      f.input :is_main, :as => :radio
      f.input :published_at
    end
    f.buttons
  end

  # sidebars
  sidebar "More stories form this subject", :only => :show do
    ul do
      Story.where(:subject_id => story.subject_id).limit(5).each do |s| 
        li link_to s.title, admin_story_path(s)
      end
    end
  end
end
