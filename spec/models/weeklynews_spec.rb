# == Schema Information
#
# Table name: weeklynews
#
#  id         :integer          not null, primary key
#  uid        :string(255)      not null
#  subject    :string(255)      not null
#  sended_at  :datetime         not null
#  url        :text(65535)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Weeklynews do
  pending "add some examples to (or delete) #{__FILE__}"
end
