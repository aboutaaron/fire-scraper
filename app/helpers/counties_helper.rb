module CountiesHelper
    def total_acres_burned
        number_with_delimiter(@county.fires.sum(:acreage))
    end

    def total_fires_ignited
        arr =[]
        @counties.each do |c|
            c.fires.each do |f|
                arr << f.name
            end
        end
        arr.count
    end
end
