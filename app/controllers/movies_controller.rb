require "net/http"
require "uri"
require 'rubygems'
require 'json'
class MoviesController < ApplicationController
    def new
    end

    def create
    	@movie=Movie.new(movie_params)
    	#render inline: @movie.title
        
        if !(@movie.title?)
            #byebug
            @movie.title = " ";
        end
    	#url="http://api.themoviedb.org/3/search/movie?query="+@movie.title+"&api_key=060a9ae33fe170591b00683218658ee6&year="+@movie.year+"&sort_by=release_date.desc"
    	if(@movie.genre?)
            url="http://api.themoviedb.org/3/discover/movie?api_key=20930962c5239d3b881390ecb5b0248d&with_genres="+@movie.genre+"&year="+@movie.year+" "
        else
            url="http://api.themoviedb.org/3/search/movie?query="+@movie.title+"&api_key=060a9ae33fe170591b00683218658ee6&year="+@movie.year+"&sort_by=release_date.desc"
        end
        uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request)

		parsed = JSON.parse(response.body)
		str=""
        @movieDetails=parsed
        #redirect_to :action =>'new'
        render "new", :locals => {:movie =>Movie.first, :movieDetails => @movieDetails}
 		#parsed["results"].each do |i|
		#	str= str + "MOVIE NAME :- " + i["title"] + "   RELEASE YEAR :- " + i["release_date"]+"\n"

			
		#end
	    #render inline: str

    #render plain: params[:movie].inspect
    end
    private
    def movie_params
    	params.require(:movie).permit(:title, :year, :genre)
    end

end
