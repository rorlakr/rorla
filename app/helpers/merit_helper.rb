module MeritHelper
  def resource_refresh
    return unless (Rails.env.development? || Rails.env.test?)
    Merit::RankRules.new.check_rank_rules      
  end
end
