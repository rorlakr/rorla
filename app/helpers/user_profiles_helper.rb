# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)      not null
#  github     :string(255)
#  intro      :text(65535)      not null
#  blog       :string(255)
#  website    :string(255)
#  company    :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string(255)
#

module UserProfilesHelper
end
