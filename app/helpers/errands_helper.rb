module ErrandsHelper
	def ordered_errand_list(collection)
    	@errands_due = collection.where.not(deadline: nil).order(:deadline, :created_at)
	    @errands_no_due = collection.where(deadline: nil).order(:created_at)
	    @errands = @errands_due + @errands_no_due
	end

	def set_display_properties(collection)
		@errands.each do |e|
		  	if !e.content or e.content.empty?
                e.content = "[No content]"
			end

		  	e.set_status 
		end
	end

end
