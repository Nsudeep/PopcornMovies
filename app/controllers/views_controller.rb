require 'date'
class ViewsController < ApplicationController
  def new
	@view = View.new
  end

  
  def create
  	#render plain: params[:view].inspect
  	#@view = (params[:view])
  	#render plain: @title
  	#render plain: @view
 	@view = View.new
 	@view.name = params[:view][:title]
 	@view.movId = params[:view][:mid].to_i
 	@view.year = Date.parse(params[:view][:date])
 	@view.photo = params[:view][:img]
 	@view.overview = params[:view][:overview]
	@view.save
    render 'new'

  end
  def rate
  end

  def review
  end

  def show
  end

  def average
  end

end
