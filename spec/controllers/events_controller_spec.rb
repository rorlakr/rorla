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

require 'spec_helper'

describe EventsController, focus:true do

  # describe "GET 'getEvents'"do
  #   it "returns http success" do
  #     #puts(subject.getEvents["data"][0]["start_time"])
  #     expect(subject.getEvents('151742221561550/events?limit=22&')["data"].length).to eq(22)
  #   end
  # end
  #
  # describe "GET 'FBevent'" do
  #   it "returns description" do
  #     expect(subject.FBevent('560777114059299?')["description"].size).to eq(235)
  #   end
  # end

  describe "GET 'meetup'", :vcr do
    it "returns meetup" do
      expect(subject.meetup["results"][0]["status"]).to eq("upcoming")
    end
  end

end
