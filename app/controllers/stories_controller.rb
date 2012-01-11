class StoriesController < ApplicationController
  impressionist :actions => [:show], :unique => [:controller_name, :action_name, :session_hash, :impressionable_id]
  
  respond_to :html, :json
  
  def index
    @stories = Story.last_n(10)
    @populars = Story.popular_n(5)
    @main = Story.main
    @popular_subjects = Subject.popular
   
  end

  def show
    @story = Story.find(params[:id])
    @populars = Story.popular_n(5)
    @popular_subjects = Subject.popular
  end

  def new
    @story = Story.new
    respond_with @story
  end

  def edit
    @story = Story.find(params[:id])
  end
  
  def create
    story = params[:story]
    binding.pry
    subject = Subject.find_or_create_by_title(story[:subject_title])
    story.delete(:subject_title)
    @story = Story.new(story)
    @story.subject_id = subject.id
    if @story.save
      respond_with @story
    else
      render action: "new"
    end
  end

end
