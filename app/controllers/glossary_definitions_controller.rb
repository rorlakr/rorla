class GlossaryDefinitionsController < ApplicationController
  before_action :set_glossary
  before_action :set_glossary_definition, only: [:update, :destroy, :like_toggle]

  def create
    @definition = @glossary.glossary_definitions.build(glossary_definition_params)
    @definition.user = current_user
    @definition.save
  end

  def update
    @definition.update(glossary_definition_params)
  end

  def destroy
    @definition.destroy
  end

  def like_toggle
    current_user.voted_up_on?(@definition) ?  @definition.unliked_by(current_user) : @definition.liked_by(current_user)
  end

  private

  def set_glossary
    @glossary = Glossary.find(params[:glossary_id])
  end

  def set_glossary_definition
    set_glossary
    @definition = @glossary.glossary_definitions.find(params[:id])
  end

  def glossary_definition_params
    params.require(:glossary_definition).permit(:id, :definition, :sentence)
  end

end
