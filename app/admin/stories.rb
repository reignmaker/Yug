ActiveAdmin.register Story do
scope :all, :default => true
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
	column "Page Views", :impressionist_count
	default_actions
  end

  show :title => :title do
  	panel "Story" do
		attributes_table_for story do
			row ("Subject") {link_to story.subject_title, admin_subject_path(story.subject_id)}
			row ("Title") {story.title}
			row ("Teaser") {story.teaser}
			row ("Content") {story.content}

		end
		div do
			h4 story.subject_title
			h2 story.title
			p story.teaser
		end
		div do
			p story.content
		end
	end
  end

  form do |f|
  	if f.object.new_record? then
  		f.object.build_subject
  		f.inputs :subject_title
  	else
  		f.inputs :subject_title
  	end
  	f.inputs do 
	  	f.input :title
	  	f.input :teaser
	  	f.input :content
  		f.input :status, :collection => Story.status_collection, :as => :radio
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
