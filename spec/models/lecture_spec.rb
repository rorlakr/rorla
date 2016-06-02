# == Schema Information
#
# Table name: lectures
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  title        :string(255)      not null
#  content      :text(65535)
#  youtube_url  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

require 'spec_helper'

describe Lecture do
  pending "add some examples to (or delete) #{__FILE__}"
end
