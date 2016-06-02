# == Schema Information
#
# Table name: courses
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  summary      :text(65535)
#  tutor_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

module CoursesHelper
end
