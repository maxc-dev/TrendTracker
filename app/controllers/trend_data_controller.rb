class TrendDataController < ApplicationController
  before_action :set_trend_datum, only: [:show, :edit, :update, :destroy]

  # GET /trend_data
  # GET /trend_data.json
  def index
    @trend_data = TrendDatum.all
  end

  # GET /trend_data/1
  # GET /trend_data/1.json
  def show
  end

  # GET /trend_data/new
  def new
    @trend_datum = TrendDatum.new
  end

  # GET /trend_data/1/edit
  def edit
  end

  # POST /trend_data
  # POST /trend_data.json
  def create
    @trend_datum = TrendDatum.new(trend_datum_params)

    respond_to do |format|
      if @trend_datum.save
        format.html { redirect_to @trend_datum, notice: 'Trend datum was successfully created.' }
        format.json { render :show, status: :created, location: @trend_datum }
      else
        format.html { render :new }
        format.json { render json: @trend_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trend_data/1
  # PATCH/PUT /trend_data/1.json
  def update
    respond_to do |format|
      if @trend_datum.update(trend_datum_params)
        format.html { redirect_to @trend_datum, notice: 'Trend datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @trend_datum }
      else
        format.html { render :edit }
        format.json { render json: @trend_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trend_data/1
  # DELETE /trend_data/1.json
  def destroy
    @trend_datum.destroy
    respond_to do |format|
      format.html { redirect_to trend_data_url, notice: 'Trend datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trend_datum
      @trend_datum = TrendDatum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trend_datum_params
      params.require(:trend_datum).permit(:woeid, :trend_id)
    end
end
