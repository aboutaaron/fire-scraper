collection @fires

attributes :acreage, :containment, :date, :location, :name

child :county do
	extends 'counties/show'
end