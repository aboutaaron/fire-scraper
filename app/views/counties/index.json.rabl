collection @counties => :counties
attributes :name, :latitude, :longitude, :id, :slug

child :fires do
	extends 'fires/index'
end