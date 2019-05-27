module RubyWifiScanner
  class OSXScanner < Scanner

    protected

    def parse
      res = raw_scan.split "\n"
      res[1..-1].map do |row|
        m = row.strip.match(/(?<ssid>\w+) (?<rssi>[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}) (?<level>-?[\d]{1,4})/i)
        WifiInfo.new(m[:ssid], m[:rssi], m[:level]) if m
      end
    end

    def raw_scan
      @raw_scan ||=
        %x{/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan}
    end

  end
end

