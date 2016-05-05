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

module CodebanksHelper
end
