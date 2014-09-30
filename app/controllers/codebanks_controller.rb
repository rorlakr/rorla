class CodebanksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_codebank, only: [:show, :edit, :update, :destroy]

  # GET /codebanks
  # GET /codebanks.json
  def index
    if params[:whose]
      @codebanks = Codebank.my_snippets(params[:whose])
      if params[:private]
        @codebanks = @codebanks.my_private_snippets(params[:whose])
      else
        @codebanks = @codebanks.my_shared_snippets(params[:whose])
      end
    else
      @codebanks = Codebank.shared
    end
    @codebanks = @codebanks.paginate(page: params[:page], per_page: 10)

  end

  # GET /codebanks/1
  # GET /codebanks/1.json
  def show
    @comment = @codebank.comments.build
    impressionist(@codebank, "message...") if !user_signed_in? or (user_signed_in? and current_user != @codebank.writer)
  end

  # GET /codebanks/new
  def new
    @codebank = Codebank.new
  end

  # GET /codebanks/1/edit
  def edit
    authorize_action_for @codebank
  end

  # POST /codebanks
  # POST /codebanks.json
  def create
    @codebank = Codebank.new(codebank_params)
    @codebank.writer = current_user

    respond_to do |format|
      if @codebank.save
        format.html { redirect_to @codebank, notice: 'Codebank was successfully created.' }
        format.json { render :show, status: :created, location: @codebank }
      else
        format.html { render :new }
        format.json { render json: @codebank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codebanks/1
  # PATCH/PUT /codebanks/1.json
  def update
    authorize_action_for @codebank
    respond_to do |format|
      if @codebank.update(codebank_params)
        format.html { redirect_to @codebank, notice: 'Codebank was successfully updated.' }
        format.json { render :show, status: :ok, location: @codebank }
      else
        format.html { render :edit }
        format.json { render json: @codebank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codebanks/1
  # DELETE /codebanks/1.json
  def destroy
    authorize_action_for @codebank
    @codebank.destroy
    respond_to do |format|
      format.html { redirect_to codebanks_url, notice: 'Codebank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_codebank
      @codebank = Codebank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def codebank_params
      params.require(:codebank).permit(:title, :summary, :snippet, :writer_id, :shared)
    end
end
