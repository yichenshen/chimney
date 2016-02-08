class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    # Gets labels to show in view
    def get_all_labels
      @labels = @app_session.labels
    end

    # Find the correct app session, then update it's access time.
    def get_app_session
      @app_session = Session.find(params[:session_id])
      @app_session.update_access_time
    end
end
