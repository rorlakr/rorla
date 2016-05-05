# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  start_time   :datetime
#  end_time     :datetime
#  location     :string(255)
#  fb_event_id  :string(255)
#  description  :text(65535)
#  latitude     :decimal(10, 6)
#  longitude    :decimal(10, 6)
#  updated_time :datetime
#  material     :text(65535)
#  modifiable   :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  event_url    :string(255)
#

class Event < ActiveRecord::Base

    # Rolify and Authroization
    resourcify
    include Authority::Abilities
    
    has_one :plaza, :as => :postitable, :dependent => :destroy

    validates_presence_of :name, :start_time, :end_time, :location, :fb_event_id, :latitude, :longitude

    default_scope { order(start_time: :desc)}


end
