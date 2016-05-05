# == Schema Information
#
# Table name: rblogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  writer_id  :integer
#  shared     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Rblog do
  pending "add some examples to (or delete) #{__FILE__}"
end
