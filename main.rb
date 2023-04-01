require_relative 'lib/film'
require_relative 'lib/film_collection'

url = 'https://www.kinopoisk.ru/lists/movies/top250/'
dir_path = "#{__dir__}/data/html_nodes"

puts 'Программа "Фильм на вечер"'
puts

begin
  FilmCollection.main_nodes(url, dir_path)
rescue Watir::Exception::UnknownObjectException
  puts 'Не удалось получить все страницы с Кинопоиска'
  puts
end

collection = FilmCollection.from_list(dir_path)

if collection.films.empty?
  collection = FilmCollection.from_dir("#{__dir__}/data")
end

puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'
puts

collection.directors.each.with_index(1) do |director, index|
  puts "#{index}. #{director}"
end

puts

user_choice = $stdin.gets.to_i

directors_amount = collection.directors.size

until (1..directors_amount).include?(user_choice)
  puts "Введите значение от 1 до #{directors_amount}"
  user_choice = $stdin.gets.to_i
end

film = collection.chosen_director_films(user_choice).sample

puts
puts 'И сегодня вечером рекомендую посмотреть:'
puts film
