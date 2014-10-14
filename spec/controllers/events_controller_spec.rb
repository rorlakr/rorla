require 'spec_helper'

describe EventsController do

  describe "GET 'FBevents'" do
    it "returns http success" do
      get 'FBevents'
      response.should be_success
    end
  end

end
