class GlossariesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_glossary, only: [:show, :edit, :update, :destroy]

  # GET /glossaries
  # GET /glossaries.json
  def index
    @glossaries = Glossary.search(params[:search]).paginate( page: params[:page], per_page: 10 )

    set_meta_tags og: {
      title: "RORLAB | Ruby & Rails Glossary",
      description: "루비와 레일스 용어집. 함께 만들어가면 어렵지 않습니다. ",
      url: glossaries_url
    }, title: "RORLAB | Ruby & Rails Glossary #{Glossary.count}"
  end

  # GET /glossaries/1
  # GET /glossaries/1.json
  def show
    set_meta_tags og: {
      title: "RORLAB Glossary | #{@glossary.term}",
      description: @glossary.glossary_definitions.map(&:definition).join(', '),
      url: glossaries_url(@glossary)
    }, title: @glossary.term
  end

  # GET /glossaries/new
  def new
    authorize_action_for Glossary
    @glossary = Glossary.new
  end

  # GET /glossaries/1/edit
  def edit
    authorize_action_for @glossary
  end

  # POST /glossaries
  # POST /glossaries.json
  def create
    authorize_action_for Glossary
    @glossary = Glossary.new(glossary_params)
    @glossary.user = current_user

    respond_to do |format|
      if @glossary.save
        format.html { redirect_to @glossary, notice: 'Glossary was successfully created.' }
        format.json { render :show, status: :created, location: @glossary }
      else
        format.html { render :new }
        format.json { render json: @glossary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /glossaries/1
  # PATCH/PUT /glossaries/1.json
  def update
    authorize_action_for @glossary
    respond_to do |format|
      if @glossary.update(glossary_params)
        format.html { redirect_to @glossary, notice: 'Glossary was successfully updated.' }
        format.json { render :show, status: :ok, location: @glossary }
      else
        format.html { render :edit }
        format.json { render json: @glossary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /glossaries/1
  # DELETE /glossaries/1.json
  def destroy
    authorize_action_for @glossary
    @glossary.destroy
    respond_to do |format|
      format.html { redirect_to glossaries_url, notice: 'Glossary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glossary
      @glossary = Glossary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def glossary_params
      params.require(:glossary).permit(:user_id, :term, :word_class, :idiomatic, :memo, glossary_definitions_attributes: [:id, :user_id, :definition, :sentence, :_destroy])
    end
end
