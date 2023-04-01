class Film
  attr_reader :title, :director, :year

  class << self
    def from_file(file)
      new(*File.readlines(file, chomp: true))
    end

    def from_html(node)
      args = [
        title_from_html(node),
        director_from_html(node),
        year_from_html(node)
      ]

      new(*args)
    end

    private

    def title_from_html(node)
      node.xpath('.//*[contains(@class, "mainTitle")]').text
    end

    def director_from_html(node)
      node.xpath('.//*[contains(@class, "truncatedText")]').first.text.
        split(': ').last
    end

    def year_from_html(node)
      node.xpath('.//*[contains(@class, "secondaryText")]').text.split(', ').
        reject(&:empty?).first
    end
  end

  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year.to_i
  end

  def to_s
    "#{@director} - #{@title} (#{@year})"
  end
end
