class LabelsController < ApplicationController
  include ErrandsHelper

  before_action :get_app_session
  before_action :get_all_labels, if: Proc.new{|c| request.get?}
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  # GET /labels
  # GET /labels.json
  def index
    @labels = @app_session.labels
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @search_term = params[:search_term]
    errand_list = @search_term ? @label.errands.match_string(@search_term) : @label.errands

    @errands = errand_list.due + errand_list.no_due
    @errands_done = errand_list.done
  end

  # GET /labels/new
  def new
    @label = @app_session.labels.new
  end

  # GET /labels/1/edit
  def edit
  end

  # POST /labels
  # POST /labels.json
  def create

    @label = @app_session.labels.new(label_params)

    respond_to do |format|
      if @label.save
        format.html { redirect_to session_labels_url(@app_session), notice: 'Label added' }
        format.json { render :show, status: :created, location: @label }
      else
        # POST usually excludes labels
        get_all_labels 
        format.html { render :new }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labels/1
  # PATCH/PUT /labels/1.json
  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to session_labels_url(@app_session), notice: 'Label updated' }
        format.json { render :show, status: :ok, location: @label }
      else
        # POST usually excludes labels
        get_all_labels 
        format.html { render :edit }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label.destroy
    respond_to do |format|
      format.html { redirect_to session_labels_url(@app_session), notice: 'Label deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label
      @label = @app_session.labels.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def label_params
      params.require(:label).permit(:name, :description)
    end
end
