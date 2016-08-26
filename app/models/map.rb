class Map < ApplicationRecord
  has_many :cities, dependent: :destroy

  def parse_cities
    nodes = Nokogiri::XML self.svg
    city_names = nodes.css("text.city")
    city_stats = nodes.css("circle.city")
    cities = {}
    city_names.each_with_index do |city, idx|
      cities[city.text] = city_stats[idx].attributes["r"].value.to_i
    end

    return cities
  end

  def save_cities
    if self.cities.blank?
      new_cities = parse_cities
      City.transaction do
        new_cities.each do |name, population|
          cities.create!(name: name, population: population)
        end
      end
    end
    cities
  end
end
