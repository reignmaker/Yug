ActiveAdmin::Dashboards.build do
    section "Moderating" do
    table_for Story.where(:status => Story::STATUS_MODERATING).order('updated_at DESC') do |s|
      s.column "Title" do |story|
       link_to story.title, admin_story_path(story)
      end
      s.column :status do |story|
        status_tag story.status, story.status_tag
      end
    end
  end
  section "Approved" do
    table_for Story.where(:status => Story::STATUS_APPROVED).order('updated_at DESC') do |s|
      s.column "Title" do |story|
       link_to story.title, admin_story_path(story)
      end
      s.column :status do |story|
        status_tag story.status, story.status_tag
      end
    end
  end
  section "Unapproved" do
    table_for Story.where(:status => Story::STATUS_UNAPPROVED).order('updated_at DESC') do |s|
      s.column "Title" do |story|
       link_to story.title, admin_story_path(story)
      end
      s.column :status do |story|
        status_tag story.status, story.status_tag
      end
    end
  end

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
