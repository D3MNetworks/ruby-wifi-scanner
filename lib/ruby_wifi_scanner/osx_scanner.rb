module RubyWifiScanner
  class OSXScanner < Scanner

    protected

    def parse scan_str
      split = scan_str.split "\n"
      resp = []
      split[1..-1].each do |row|
        break if row == ""
        m = row.strip.match(/(?<ssid>\w*)? ?(?<rssi>[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}) (?<level>-?[\d]{1,4})\s\s(?<channel>[0-9,+-]+)/i)
        resp << WifiInfo.new(m[:ssid], m[:rssi], m[:level], m[:channel]) if m
      end
      resp.compact
    end

    def raw_scan
      @raw_scan ||=
        %x{/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --scan}
    end

  end
end

