require 'film_collection'
require 'film'
require 'watir'
require 'nokogiri'

describe FilmCollection do
  subject { described_class.from_dir("#{__dir__}/fixtures/files") }

  describe '.from_dir' do
    it 'returns new FilmCollection object' do
      expect(subject).to be_a(described_class)
    end

    it 'contains only Film objects' do
      expect(subject.films).to all(be_a(Film))
    end

    it 'contains correct amount of Film objects' do
      expect(subject.films.size).to eq(4)
    end
  end

  describe '.from_list' do
    let(:dir) { "#{__dir__}/fixtures/files" }
    let(:film_collection) { described_class.from_list(dir) }

    it 'returns new FilmCollection object' do
      expect(film_collection).to be_a(described_class)
    end

    it 'contains only Film objects' do
      expect(film_collection.films).to all(be_a(Film))
    end

    it 'contains correct amount of Film objects' do
      expect(film_collection.films.size).to eq(51)
    end
  end

  describe '#initialize' do
    it 'assigns correct instance variables' do
      expect(subject.films).not_to be_empty
    end

    it 'contains only Film objects' do
      expect(subject.films).to all(be_a(Film))
    end
  end

  describe '#chosen_director_films' do
    it 'returns array of films by director' do
      expect(subject.chosen_director_films(1)).
        to all(have_attributes(director: 'Дени Вильнев'))
    end
  end

  describe '#directors' do
    it 'returns array of directors' do
      expect(subject.directors).to eq(['Дени Вильнев', 'Джон Карпентер'])
    end
  end
end
