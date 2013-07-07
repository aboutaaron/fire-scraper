# Storing json response in property consider:
# collection @counties => :counties
object @counties
attributes :name, :latitude, :longitude, :id, :slug

child :fires do
	extends 'fires/index'
end