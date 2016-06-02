# == Schema Information
#
# Table name: schedules
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  name           :string(255)      not null
#  info           :text(65535)
#  venue          :string(255)
#  start_date     :datetime
#  end_date       :datetime
#  repeating      :boolean
#  charged        :boolean          default(FALSE)
#  charge_amount  :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  pre_start_date :datetime
#  pre_end_date   :datetime
#

require 'spec_helper'

describe Schedule do
  pending "add some examples to (or delete) #{__FILE__}"
end
