class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]
  before_action :load_cycle

  # GET /days
  # GET /days.json
  def index
    @days = @cycle.days.all
    @cycle_presenter = CyclePresenterService.build(@cycle)
  end

  # GET /days/1
  # GET /days/1.json
  def show
    @cycle.days.find(params[:id])
  end

  # GET /days/1/edit
  def edit
    @cycle.days.find(params[:id])
  end

  # POST /days
  # POST /days.json
  def create
    @day = @cycle.days.new(day_params)

    respond_to do |format|
      if @day.save
        format.html { redirect_to [@cycle, @day], notice: 'Day was successfully created.' }
        format.json { render :show, status: :created, location: @day }
      else
        format.html { render :new }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1
  # PATCH/PUT /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to cycle_days_path(@cycle), notice: 'Day was successfully updated.' }
        format.json { render :show, status: :ok, location: @day }
      else
        format.html { render :edit }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.json
  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to days_url, notice: 'Day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day
      @day = Cycle.find(params[:cycle_id]).days.find(params[:id])
    end

    def load_cycle
      @cycle = Cycle.find(params[:cycle_id])
      redirect_to cycles_url unless @cycle.user == current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def day_params
      params.require(:day).permit(:bleeding, :sensation, :characteristics, :cervix, :temp, :number, :date, :weight, :cramps, :irritability, :sensitivity, :drinks, :hours_sleep)
    end
end
