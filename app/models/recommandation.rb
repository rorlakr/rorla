class Recommandation < ActiveRecord::Base
  belongs_to :applier
  belongs_to :recommander
end
