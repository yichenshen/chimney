class Session < ActiveRecord::Base
    has_many :errands, inverse_of: :session, dependent: :destroy
    has_many :labels, inverse_of: :session, dependent: :destroy

    def update_access_time
        self.update_attribute(:accessed_at, DateTime.now)
    end
end
