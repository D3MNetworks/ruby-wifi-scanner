module RubyWifiScanner
  class LinuxScanner < Scanner

    protected

    def parse
      res = raw_scan.split "\n"
      res[1..-1].map do |row|
        m = row.strip.match(/(?<level>-?[\d.]{4,6})\s+(?<rssi>[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2}:[a-f0-9]{2})\s*(?<ssid>\w+)?/i)
        WifiInfo.new(m[:ssid], m[:rssi], m[:level]) if m
      end
    end

    def raw_scan
      @raw_scan ||=
        %x{sudo iw dev $DEVICE scan | awk -f wlan_scan.awk | sort}
    end
  end
end

