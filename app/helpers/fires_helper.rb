module FiresHelper
    def us_fire_totals
        require "mechanize"
        a = Mechanize.new
        a.get("http://www.ncdc.noaa.gov/sotc/fire/")
        a.page.search("#ytd-fire-stats tr td")[0].text.gsub(",","").to_i
    end
end