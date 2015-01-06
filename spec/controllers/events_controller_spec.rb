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
