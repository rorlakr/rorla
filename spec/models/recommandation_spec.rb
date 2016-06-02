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

require 'spec_helper'

describe Recommandation do
  pending "add some examples to (or delete) #{__FILE__}"
end
