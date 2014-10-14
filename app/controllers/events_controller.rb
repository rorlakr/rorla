class EventsController < ApplicationController
  def FBevents
    uri = URI.parse('https://graph.facebook.com/v2.1/151742221561550/events?access_token=CAACEdEose0cBAJ7pTu6lSBugNDCzhV4XgQ21uIYdMOmInFDax14nZCJCJn5fjKwJ8lMnhQgSanZBEil064OABPOaOZCpYa7aCSEmlSqIl27Xh14iIDXFEKYBSvTUiKXwyewqR3dbYVD39dlgojTi2N5IGKtXXG1Flbmr5qU8liWUfwujvGZCa8Tz7hfDZASBKlMWtt2CyLT6J26ywHrEZC')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl=true
    http.ssl_version = :TLSv1
    response = http.get(uri.request_uri)

  end
end
