class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Gets labels for all actions
  before_action :get_all_labels, if: Proc.new{|c| request.get?}
  
  private
    # Gets labels to show in view
    def get_all_labels
      @labels = Label.all
    end
end
