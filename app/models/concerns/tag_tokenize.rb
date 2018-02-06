module TagTokenize
  extend ActiveSupport::Concern

  def tag_tokens=(tokens)
    tag_ids = Tag.ids_from_tokens(tokens)
    self.tag_list = Tag.where(id: tag_ids).pluck(:name).join(', ')
  end

  def tag_tokens
    Tag.order(:name).where(id: tag_ids)
  end
end
