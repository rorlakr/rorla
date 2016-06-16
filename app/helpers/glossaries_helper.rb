module GlossariesHelper
  def likers(definition)
    likers = definition.votes_for.up
    if likers.size < 11
      likers.voters.map(&:email).join(', ')
    else
      likers.voters[0,10].map(&:email).join(', ') + " 외 #{likers.size - 10 }"
    end
  end
end
