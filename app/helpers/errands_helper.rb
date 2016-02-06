module ErrandsHelper
	# Gets a list of uncompleted TODOs, ordered by deadline first, then by time created
    def ordered_errand_list(collection)
    	errands_due = collection.where(done: false).where.not(deadline: nil).order(:deadline, :created_at)
	    errands_no_due = collection.where(done: false, deadline: nil).order(:created_at)
	    
        errands_due + errands_no_due
	end

    # Gets a list of completed TODOs,
    def completed_errands(collection)
        collection.where(done: true).order(:created_at)
    end

	def set_display_properties(collection)
		collection.each do |e|
		  	if !e.content or e.content.empty?
                e.content = "[No content]"
			end

		  	e.set_status 
		end
	end

end
