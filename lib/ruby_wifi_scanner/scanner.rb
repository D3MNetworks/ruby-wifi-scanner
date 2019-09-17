module RubyWifiScanner
  class Scanner
    attr_reader :networks

    WifiInfo = Struct.new(:ssid, :rssi, :level, :channel)

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
      @networks = parse(@raw_scan).sort_by { |w| -w.level }
    end

    def deep_scan
      ssids = @networks.map(&:ssid).uniq
      @networks = []

      ssids.each do |ssid|
        @networks += parse directed_scan ssid
      end
    end

    def print_fmt freq: nil, **kargs
      @networks.select do |n|
        if freq.nil?
          true
        else
          channel, _ = n.channel.split ?,

          if freq == '2'
            channel.to_i <= 14
          else
            channel.to_i >= 32 && channel.to_i <= 73
          end
        end


      end.map do |n|
        "#{n.rssi}\t#{n.level}\t#{n.channel}\t#{n.ssid}"
      end
    end

    def print_json
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
