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
end