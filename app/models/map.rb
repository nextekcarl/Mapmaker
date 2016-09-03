class Map < ApplicationRecord
  has_many :cities, dependent: :destroy

  before_save :sanitize_svg

  def parse_cities
    nodes = Nokogiri::XML self.svg
    city_names = nodes.css("text.city")
    city_stats = nodes.css("circle.city")
    cities = {}
    city_names.each_with_index do |city, idx|
      cities[city.text] = {}
      cities[city.text][:population] = city_stats[idx].attributes["r"].value.to_i
      cities[city.text][:color] = city_stats[idx].attributes["style"].value.match(/fill:\s(\w+);.+/)[1]
    end

    return cities
  end

  def save_cities
    if self.cities.blank?
      new_cities = parse_cities
      City.transaction do
        new_cities.each do |name, stats|
          cities.create!(name: name, population: stats[:population], color: stats[:color] )
        end
      end
    end
    cities
  end

  private

    def sanitize_svg
      unsafe_svg   = Nokogiri::XML(self.svg)
      xslt  = Nokogiri::XSLT(File.read(File.join(Rails.root,'/lib/assets/safe_svg.xslt')))
      self.svg = xslt.transform(unsafe_svg)
    end
end
