class Errand < ActiveRecord::Base
	has_and_belongs_to_many :labels, inverse_of: :errand
	validates :title, presence: true, length: {maximum: 100}

	attr_accessor :status

	def toggle_state
		self.done = !self.done
	end

	def set_status
		if self.deadline and self.deadline < Date.today
        	self.status = :late
      	elsif self.deadline and self.deadline == Date.today
        	self.status = :due_today
      	end
	end
end
