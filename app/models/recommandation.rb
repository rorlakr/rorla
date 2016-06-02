# == Schema Information
#
# Table name: recommandations
#
#  id             :integer          not null, primary key
#  schedule_id    :integer
#  applier_id     :integer
#  recommander_id :integer
#  score          :integer          default(0)
#  letter         :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Recommandation < ActiveRecord::Base
  belongs_to :applier
  belongs_to :recommander, class_name: "User", foreign_key: :recommander_id
end
