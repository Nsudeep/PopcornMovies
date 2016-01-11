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
    #@average = @average["average_rating"]
    @average_rating = average

    #@average = MovieRate.select("movId,avg(rate) as average_rate,sum(rate) as total_rate").group("movId").order('average_rate DESC')
    @average_rating=JSON.parse(@average_rating)
    @average_rating=@average_rating[0]["average_rating"]
    @total_rating=JSON.parse(@total_rating)
    @total_rating = @total_rating[0]["total_rating"]
   # @average=@average[1]["average_rating"]
    if(View.exists?(movId: @view.movId))
      
    else
	     #@view.save
    end

    render "new", :locals => {:view =>@view, :average => @average_rating,:total => @total_rating}
    
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
        MovieRate.select("avg(rate) as average_rating").group("movId").to_json

  end

  def total
    MovieRate.select("count(rate) as total_rating").group("movId").to_json
  end

  def viewreview
  end

end
