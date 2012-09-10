module FiresHelper
    require "mechanize"

    # Acres burned
    def acres
        total_acres = []
        @fires.each do |fuego|
            total_acres << fuego.total_acres_burned
        end
        total_acres.inject(:+)
    end

    # Date of data set
    def date_of_fire_stats
        a = Mechanize.new
        a.get("http://www.ncdc.noaa.gov/sotc/fire/")
        a.page.search("h1").text.gsub("State of the ClimateWildfires","")
    end

    # Total Acres burned in USA to date
    def total_acres_burned_usa_to_date
        a = Mechanize.new
        a.get("http://www.ncdc.noaa.gov/sotc/fire/")
        a.page.search("#ytd-fire-stats tr td")[0].text.gsub(",","").to_i
    end

    # Total number of fires in USA to date
    def number_of_fires_in_usa_to_date
        a = Mechanize.new
        a.get("http://www.ncdc.noaa.gov/sotc/fire/")
        a.page.search("#ytd-fire-stats tr td")[6].text.gsub(",","").to_i
    end

end