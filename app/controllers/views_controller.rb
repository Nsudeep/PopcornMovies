require 'date'
require 'json'
class ViewsController < ApplicationController
  def new
	@view = View.new
  end
  def index
      @movie = View.joins(:movie_rates)
  end
  
  
  def create
  
 	  @view = View.new
 	  @view.name = params[:view][:title]
 	  @view.movId = params[:view][:mid].to_i
 	  @view.year = Date.parse(params[:view][:date])
 	  @view.photo = params[:view][:img]
 	  @view.overview = params[:view][:overview]
    @total_rating = total
    @average_rating = average
    if(View.exists?(movId: @view.movId))
      
    else
	     @view.save
    end

    render "new", :locals => {:view =>@view}
    
  end
  def rate
  	@rate = MovieRate.new()
    @rate.uId = session[:uId]
    @rate.uName = session[:userDetails]
  	@rate.movId = params[:rate][:mid]
    @rate.rate = params[:rate][:rating]
    @rate.review = params[:rate][:review]
    @rate.view_id = params[:rate][:id]
    @rate.save
    render "show", :locals => {:rate => @rate}
    @v = eval(params[:rate][:view])
    @view = View.new
    @view.photo = @v["photo"]
    @view.name = @v["name"]
    @view.movId=@v["movId"]
    @view.overview=@v["overview"]
    @view.year=@v["year"]
    
    #render "show", :locals => {:view => @view}
  end

  def review
  end

  def show
  end

  def average
  end

  def total
  end

  def viewreview
  end

end
