require 'spec_helper'

describe InfoController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'howto'" do
    it "returns http success" do
      get 'howto'
      response.should be_success
    end
  end

  describe "GET 'copyright'" do
    it "returns http success" do
      get 'copyright'
      response.should be_success
    end
  end

  describe "GET 'security'" do
    it "returns http success" do
      get 'security'
      response.should be_success
    end
  end

end
