class ImagesController < ApplicationController
	respond_to :html, :json
	
	def index
		@images = Image.all

	end
	def show
		@image = Image.find(params[:id])
	end
	def new
		@image = Image.new
		respond_with @image
	end

	def create
		@image = Image.new(params[:image])
		if @image.save
			respond_with @image
		else
			render action 'new'
		end
	end

end