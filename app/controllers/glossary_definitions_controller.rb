class GlossaryDefinitionsController < ApplicationController

  def like_toggle
    @glossary = Glossary.find(params[:glossary_id])
    @definition = @glossary.glossary_definitions.find(params[:id])
    current_user.voted_up_on?(@definition) ?  @definition.unliked_by(current_user) : @definition.liked_by(current_user)
  end

end
