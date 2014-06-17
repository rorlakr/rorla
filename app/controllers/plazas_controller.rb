class PlazasController < ApplicationController
  before_action :set_plaza, only: [:show, :edit, :update, :destroy]

  # GET /plazas
  # GET /plazas.json
  def index
    @plazas = Plaza.all
  end

  # GET /plazas/1
  # GET /plazas/1.json
  def show
  end

  # GET /plazas/new
  def new
    @plaza = Plaza.new
  end

  # GET /plazas/1/edit
  def edit
  end

  # POST /plazas
  # POST /plazas.json
  def create
    @plaza = Plaza.new(plaza_params)

    respond_to do |format|
      if @plaza.save
        format.html { redirect_to @plaza, notice: 'Plaza was successfully created.' }
        format.json { render :show, status: :created, location: @plaza }
      else
        format.html { render :new }
        format.json { render json: @plaza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plazas/1
  # PATCH/PUT /plazas/1.json
  def update
    respond_to do |format|
      if @plaza.update(plaza_params)
        format.html { redirect_to @plaza, notice: 'Plaza was successfully updated.' }
        format.json { render :show, status: :ok, location: @plaza }
      else
        format.html { render :edit }
        format.json { render json: @plaza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plazas/1
  # DELETE /plazas/1.json
  def destroy
    @plaza.destroy
    respond_to do |format|
      format.html { redirect_to plazas_url, notice: 'Plaza was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plaza
      @plaza = Plaza.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plaza_params
      params[:plaza]
    end
end
