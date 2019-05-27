require "ruby_wifi_scanner/version"
require "ruby_wifi_scanner/scanner"
require "ruby_wifi_scanner/osx_scanner"
require "ruby_wifi_scanner/linux_scanner"


module RubyWifiScanner
  class Error < StandardError; end
  class NotImplemented < Error ; end
  # Your code goes here...

end
