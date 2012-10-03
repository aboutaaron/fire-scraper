module CountiesHelper
    def total_acres_burned
        number_with_delimiter(@county.fires.sum(:acreage))
    end
end
