require 'spec_helper'

describe EventsController,focus:true do
 let(:http_response) {"OK"}
  describe "GET 'FBevents'", :vcr do
    it "returns http success" do
      subject.FBevents.message.should == http_response
    end
  end

end
