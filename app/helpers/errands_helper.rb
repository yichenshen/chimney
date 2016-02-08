module ErrandsHelper

	def set_display_properties(collection)
		collection.each do |e|
		  	if !e.content or e.content.empty?
                e.content = "[No content]"
			end

		  	e.set_status 
		end
	end

end
