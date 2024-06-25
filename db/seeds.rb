require 'json'
require 'open-uri'

begin
  url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
  ingredient_serialized = URI.open(url).read
  ingredient = JSON.parse(ingredient_serialized)
  puts "Adding new ingredients from API"
  ingredient["drinks"].each do |item|
    Ingredient.create(name: item["strIngredient1"])
  end
rescue StandardError => e
  puts "Failed to fetch ingredients from API: #{e.message}"
end

puts "Adding default ingredients"
default_ingredients = [
  "Lemon",
  "Ice",
  "Mint leaves",
  "Vodka",
  "Gin",
  "Rum",
  "Tequila",
  "Triple Sec",
  "Cranberry Juice",
  "Orange Juice"
]

default_ingredients.each do |ingredient|
  Ingredient.create(name: ingredient)
end

puts "Created #{Ingredient.count} ingredients."
