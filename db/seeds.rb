# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

puts "Cleaning database..."
Movie.destroy_all

url = "http://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

puts "Seeding Movies..."
movies["results"].each do |result|
  Movie.create(title: result["title"],
  overview: result["overview"],
  rating: result["vote_average"],
  poster_url: "https://image.tmdb.org/t/p/w500#{result["poster_path"]}")
end
puts "#{Movie.all.length} movies created successfully !!"
