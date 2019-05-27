module RubyWifiScanner
  class Scanner
    attr_reader :networks

    WifiInfo = Struct.new(:ssid, :rssi, :level)

    def self.create(raw_scan=nil)
      case
      when osx? then OSXScanner.new(raw_scan)
      when linux? then LinuxScanner.new(raw_scan)
      end
    end

    private_class_method
    def self.osx?
      RUBY_PLATFORM =~ /darwin/
    end

    private_class_method
    def self.linux?
      RUBY_PLATFORM =~ /linux/
    end


    def initialize(raw_scan = nil)
      @raw_scan = raw_scan || self.raw_scan
      @networks = parse.sort_by { |w| -w.level }
    end

    def print_fmt
      @networks.map do |n|
        "#{n.rssi}\t#{n.level}\t#{n.ssid}"
      end
    end

    protected

    def parse
      raise NotImplemented
    end

    def raw_scan
      raise NotImplemented
    end

  end
end
