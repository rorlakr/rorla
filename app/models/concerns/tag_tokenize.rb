module TagTokenize

  attr_accessor :tag_tokens

  def tag_tokens=(tokens)
    tag_ids = Tag.ids_from_tokens(tokens)
    self.tag_list = Tag.where( id: tag_ids).pluck(:name)
  end

  def tag_tokens
    Tag.order(:name).where( id: self.tag_ids )
  end

end