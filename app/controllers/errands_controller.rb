class ErrandsController < ApplicationController
  include ApplicationHelper

  before_action :set_errand, only: [:show, :edit, :update, :destroy]
  before_action :ensure_json_request, only: [:show]

  # GET /errands
  # GET /errands.json
  def index
    @errands_due = Errand.where.not(deadline: nil).order(:deadline, :created_at)
    @errands_no_due = Errand.where(deadline: nil).order(:created_at)
    @errands = @errands_due + @errands_no_due

    @errands.each do |e|
      if !e.content or e.content.empty?
        e.content = "[No content]"
      end

      if e.deadline and e.deadline < Date.today
        e.status = :late
      elsif e.deadline and e.deadline == Date.today
        e.status = :due_today
      end
          
    end
  end

  # JSON only
  # GET /errands/1.json
  def show
  end

  # GET /errands/new
  def new
    @errand = Errand.new
  end

  # GET /errands/1/edit
  def edit
  end

  # POST /errands
  # POST /errands.json
  def create
    @errand = Errand.new(errand_params)

    respond_to do |format|
      if @errand.save
        format.html { redirect_to errands_url, notice: 'TODO has been added' }
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
        format.html { redirect_to errands_url, notice: 'TODO has been updated' }
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
    respond_to do |format|
      format.html { redirect_to errands_url, notice: 'TODO is removed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_errand
      @errand = Errand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def errand_params
      params[:errand][:label_ids] ||= []
      params.require(:errand).permit(:title, :content, :deadline ,label_ids: [])
    end
end
