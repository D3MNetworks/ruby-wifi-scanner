module RubyWifiScanner
  class LinuxScanner < Scanner
    protected

    def parse
      scan = raw_scan.scan(/
        ^BSS\s([a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2})
        .+?
        signal:\s([\d.-]+?)\sdBm$
        .+?
        SSID:\s(\w+?)$
      /mx)

      scan.map do |rssi,level,ssid|
        WifiInfo.new(ssid, rssi, level)
      end
    end

    def raw_scan
      return @raw_scan if @raw_scan

      device = ENV["DEVICE"] || 'wlan0'

      @raw_scan = %x{sudo iw dev #{device} scan}
    end
  end
end

