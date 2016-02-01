class Errand < ActiveRecord::Base
	has_and_belongs_to_many :labels, inverse_of: :errand
end
