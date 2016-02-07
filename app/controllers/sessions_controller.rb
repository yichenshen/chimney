class SessionsController < ApplicationController
  
  # GET /sessions
  # Assigns a session if not present. Redirects to main page otherwise
  def index
    respond_to do |format|
        @app_session = Session.find_by_id(session[:current_app_session_id])
        
        if @app_session
            format.html{redirect_to session_errands_url(@app_session)}
        else
            @app_session = new_app_session
            session[:current_app_session_id] = @app_session.id
            format.html{redirect_to session_errands_url(@app_session)}
        end
    end
  end

  def show
    @session = Session.find(params[:id])

    respond_to do |format|
        format.html{redirect_to session_errands_url(@session)}
    end
  end

  private
    #Creates a new session
    def new_app_session
        app_session = Session.new
        app_session.save

        app_session
    end
end
