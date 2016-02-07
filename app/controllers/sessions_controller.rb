class SessionsController < ApplicationController
  def index

  end

  def show
    @session = Session.find(params[:id])

    respond_to do |format|
        format.html{redirect_to session_errands_url(@session)}
    end
  end
end
