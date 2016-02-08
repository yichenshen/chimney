class SessionsController < ApplicationController
  
  # GET /sessions
  # Assigns a session if not present. Redirects to main page otherwise
  def index
    respond_to do |format|
        @app_session = Session.find_by_id(cookies[:current_app_session_id])
        
        if @app_session
            format.html{redirect_to session_errands_url(@app_session)}
        else
            @app_session = new_app_session
            cookies[:current_app_session_id] = @app_session.id
            format.html{redirect_to session_errands_url(@app_session)}
        end
    end
  end

  # GET /sessions/1
  # Shows a particular session. Redirects to the TODO screen
  def show
    @app_session = Session.find(params[:id])

    respond_to do |format|
        format.html{redirect_to session_errands_url(@app_session)}
    end
  end

  # POST /sessions/1/setsession
  # Sets the default app session
  def setsession
    @app_session = Session.find(params[:id])
    cookies[:current_app_session_id] = @app_session.id

    respond_to do |format|
        format.html{redirect_to session_errands_url(@app_session)}
    end

  end

  private
    #Creates a new session
    def new_app_session
        app_session = Session.new
        app_session.accessed_at = DateTime.now
        app_session.save

        app_session
    end
end
