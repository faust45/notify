require('rubygems')
gem('twitter4r', '0.3.2')
require('twitter')

Twitter::Client.configure do |conf|
  conf.protocol = :ssl
  conf.host = 'twitter.com'
  conf.port = 443

  # We can also change the User-Agent and X-Twitter-Client* HTTP headers
  conf.user_agent = 'MyAppAgentName'
  conf.application_name = 'Noify'
  #conf.application_version = '1'
  #conf.application_url = 'http://myapp.url'

  # Twitter (not Twitter4R) will have to setup a source ID for your application to get it
  # recognized by the web interface according to your preferences.
  # To see more information how to go about doing this, please referen to the following thread:
  # http://groups.google.com/group/twitter4r-users/browse_thread/thread/c655457fdb127032
  conf.source = "your-source-id-that-twitter-recognizes"
end
