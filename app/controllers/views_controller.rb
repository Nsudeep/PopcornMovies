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
    @total_rating = ""
    @total_rating = total
    @average_rating = ""
    @average_rating = average

    #@average = MovieRate.select("movId,avg(rate) as average_rate,sum(rate) as total_rate").group("movId").order('average_rate DESC')
    @average_rating=JSON.parse(@average_rating)
    if(@average_rating.empty? != true)
      @average_rating=@average_rating[0]["average_rating"]
    else
      @average_rating=""
    end
    @total_rating=JSON.parse(@total_rating)
    if(@total_rating.empty? != true)
      @total_rating=@total_rating[0]["total_rating"]
    else
      @total_rating=""
    end

    if(View.exists?(movId: @view.movId))
    else
	     @view.save
    end
    
    @reviews = viewreview
    @reviews=JSON.parse(@reviews)

    render "new", :locals => {:view =>@view, :average => @average_rating,:total => @total_rating, :reviews => @reviews}
    
  end
  def rate
  	@rate = MovieRate.new()
    @rate.uId = session[:uId]
    @rate.uName = session[:userDetails]
  	@rate.movId = params[:rate][:mid]
    @rate.rate = params[:rate][:rating]
    @rate.review = params[:rate][:review]
    @view_id = viewId
    @view_id = JSON.parse(@view_id)
    @rate.view_id = @view_id[0]["id"]
    @alreadyvoted=checkRate
    @a=false
    @alreadyvoted.each do |i|
      if(i["movId"] == @rate.movId)
        @a=true
      end
    end
    #render plain: @a.inspect
    if(!@a)
      @rate.save
      #render "show", :locals => {:rate => @rate}
    end
    @v = eval(params[:rate][:view])
    @view = View.new
    @view.photo = @v["photo"]
    @view.name = @v["name"]
    @view.movId=@v["movId"]
    @view.overview=@v["overview"]
    @view.year=@v["year"]
    
    render "show", :locals => {:view => @view}
  end

  def checkRate
    @mid = MovieRate.select("movId").where("uId = ?", session[:uId]).to_json
    @mid=JSON.parse(@mid)
    
  end

  def review
  end

  def show
  end

  def average
    MovieRate.select("avg(rate) as average_rating").group("movId").having("movId = ?", @view.movId).to_json
  end

  def total
    MovieRate.select("count(rate) as total_rating").group("movId").having("movId = ?", @view.movId).to_json
  end

  def viewreview
    MovieRate.select("uName, review").where("movId = ?", @view.movId).to_json
  end

  def viewId
    View.select("views.id").where("movId = ?", @rate.movId).to_json
  end

end
