class Session < ActiveRecord::Base
    has_many :errands, inverse_of: :session, dependent: :destroy
    has_many :labels, inverse_of: :session, dependent: :destroy
end
