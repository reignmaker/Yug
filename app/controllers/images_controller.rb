class ImagesController < ApplicationController
	respond_to :html, :json
	
	def index
		@images = Image.all
		render :json => @images.collect { |i| i.to_jq_upload }.to_json

	end
	def show
		@image = Image.find(params[:id])
		render :json => [@image.to_jq_upload].to_json
	end
	def new
		@image = Image.new
		respond_with @image
	end

	def create
		@image = Image.new(params[:image])
		if @image.save
			render :json => [@image.to_jq_upload].to_json
		else
			render :json => [{:error => "custom_failure"}], :status => 304
		end
	end

end