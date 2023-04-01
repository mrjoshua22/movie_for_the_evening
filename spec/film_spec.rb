require 'film'
require 'nokogiri'

describe Film do
  subject { described_class.new('Драйв', 'Николас Виндинг Рефн', '2011') }

  describe '.from_file' do
    it 'returns new Film object' do
      expect(described_class.from_file("#{__dir__}/fixtures/files/01.txt")).
        to be_a(described_class)
    end
  end

  describe '.from_html' do
    let(:node) { Nokogiri::HTML(File.read("#{__dir__}/fixtures/files/green_mile.html")) }
    let(:film) { described_class.from_html(node) }

    it 'returns new Film object' do
      expect(film).to be_a(described_class)
    end

    it 'assigns correct instance variables values' do
      expect(film).to have_attributes(
        title: 'Зеленая миля',
        director: 'Фрэнк Дарабонт',
        year: 1999
      )
    end
  end

  describe '#initialize', :aggregate_failures do
    it 'assigns instance variables' do
      expect(subject.title).to eq('Драйв')
      expect(subject.director).to eq('Николас Виндинг Рефн')
      expect(subject.year).to eq(2011)
    end
  end

  describe '#to_s' do
    it 'returns a string' do
      expect(subject.to_s).to eq('Николас Виндинг Рефн - Драйв (2011)')
    end
  end
end
