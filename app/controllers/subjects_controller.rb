class SubjectsController < ApplicationController
	autocomplete :subject, :title, :full =>true
	respond_to :html
	
	def index
		@subjects = Subject.find(:all)
		
	end

	def show
		@subject = Subject.find(params[:id])
		@stories = @subject.all_published
	end

	def new
		@subject = Subject.new
		respond_with @subject
	end

	def create
		@subject = Subject.new(params[:subject])
		if @subject.save
			respond_with @subject
		else
			render action: "new"
		end
	end

end