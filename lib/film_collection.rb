require 'nokogiri'
require 'watir'

class FilmCollection
  attr_reader :films

  class << self
    def from_dir(dir_path)
      films =
        Dir["#{dir_path}/*txt"].map do |file|
          Film.from_file(file)
        end

      new(films)
    end

    def from_list(dir_path)
      films = film_nodes(dir_path).map { |node| Film.from_html(node) }

      new(films)
    end

    def main_nodes(url, dir_path)
      browser = Watir::Browser.new(:chrome, headless: true)

      pages_count(browser, url).each do |page_number|
        browser.goto("#{url}?page=#{page_number}")

        File.write(
          "#{dir_path}/#{Time.now.strftime('%s%L')}.html",
          browser.main.html
        )
      end

      browser.close
    end

    private

    def film_nodes(dir_path)
      Dir["#{dir_path}/*html"].map do |file|
        Nokogiri::HTML(File.read(file)).
          xpath('//a[contains(@class, "base-movie-main-info")]')
      end
                              .flatten(1)
    end

    def pages_count(browser, url)
      browser.goto(url)
      last_page =
        browser.elements(xpath: "//a[contains(@class, 'styles_page')]").
        last.text.to_i

      [*1..last_page]
    end
  end

  def initialize(films)
    @films = films
  end

  def chosen_director_films(user_input)
    @films.select { |film| film.director == directors[user_input - 1] }.
      uniq { |film| film.title }
  end

  def directors
    @films.map(&:director).uniq
  end
end
