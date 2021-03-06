class ErrandsController < ApplicationController
  include ApplicationHelper
  include ErrandsHelper

  before_action :get_app_session
  before_action :set_errand, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :get_all_labels, if: Proc.new{|c| request.get?}
  before_action :ensure_json_request, only: [:show]

  # GET /errands
  # GET /errands.json
  def index
    @search_term = params[:search_term]
    errand_list = @search_term ? @app_session.errands.match_string(@search_term) : @app_session.errands

    @errands = errand_list.due + errand_list.no_due
    @errands_done = errand_list.done
  end

  # JSON only
  # GET /errands/1.json
  def show
  end

  # GET /errands/new
  def new
    @errand = @app_session.errands.new
  end

  # GET /errands/1/edit
  def edit
  end

  # POST /errands
  # POST /errands.json
  def create
    @errand = @app_session.errands.new(errand_params)

    respond_to do |format|
      if @errand.save
        format.html { redirect_to session_errands_url(@app_session), notice: 'TODO has been added' }
        format.json { render :show, status: :created, location: @errand }
      else
        # POST usually excludes labels
        get_all_labels
        format.html { render :new }
        format.json { render json: @errand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /errands/1
  # PATCH/PUT /errands/1.json
  def update
    respond_to do |format|
      if @errand.update(errand_params)
        format.html { redirect_to session_errands_url(@app_session), notice: 'TODO has been updated' }
        format.json { render :show, status: :ok, location: @errand }
      else
        # POST usually excludes labels
        get_all_labels
        format.html { render :edit }
        format.json { render json: @errand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /errands/1
  # DELETE /errands/1.json
  def destroy
    @errand.destroy

    path = session_errands_url(@app_session)
    if params[:label]
      @label = @app_session.labels.find(params[:label])
      path = session_label_url(@app_session, @label)
    end

    respond_to do |format|
      format.html { redirect_to path, notice: 'TODO is removed' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /errands/1/toggle
  # Toggles done state of TODO
  def toggle

    @errand.toggle_state

    new_state_str = @errand.done ? "done" : "not done"

    path = session_errands_url(@app_session)

    if params[:label]
      @label = @app_session.labels.find(params[:label])
      path = session_label_url(@app_session, @label)
    end

    respond_to do |format|
      if @errand.save
          format.html { redirect_to path, notice: 'TODO marked as ' + new_state_str }
          format.json { render :show, status: :ok, location: @errand }
      else
        # POST usually excludes labels
        get_all_labels
        format.html { redirect_to session_errands_url(@app_session), notice: 'Error marking TODO, try again later' }
        format.json { render json: @errand.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_errand
      @errand = @app_session.errands.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def errand_params
      params[:errand][:label_ids] ||= []
      params.require(:errand).permit(:title, :content, :deadline ,label_ids: [])
    end
end
