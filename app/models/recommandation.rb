class Recommandation < ActiveRecord::Base
  belongs_to :applier
  belongs_to :recommander, class_name: "User", foreign_key: :recommander_id
end
