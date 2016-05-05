# == Schema Information
#
# Table name: codebanks
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  summary    :text(65535)
#  snippet    :text(65535)      not null
#  writer_id  :integer
#  shared     :boolean
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Codebank do
  pending "add some examples to (or delete) #{__FILE__}"
end
