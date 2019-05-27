require "test_helper"
require "byebug"
require "ruby_wifi_scanner/scanner"
require "ruby_wifi_scanner/osx_scanner"
require "ruby_wifi_scanner/linux_scanner"


class RubyWifiScannerTest < Minitest::Test
  def setup
    @mock_osx_scan = open("./test/osx.out").read
    @mock_linux_scan = open("./test/linux.out").read
  end

  def test_that_it_has_a_version_number
    refute_nil ::RubyWifiScanner::VERSION
  end

  def test_it_returns_a_result
    # result = RubyWifiScanner.scan
    # assert result.length > 0
  end

  def test_scanner
    # rws = RubyWifiScanner::Scanner.create
    # assert rws.networks.first.level > rws.networks.last.level
  end

  def test_osx
    rws = RubyWifiScanner::OSXScanner.new @mock_osx_scan
    assert rws.networks.first.level < rws.networks.last.level
  end

  def test_linux
    rws = RubyWifiScanner::LinuxScanner.new @mock_linux_scan
    assert rws.networks.first.level < rws.networks.last.level
  end

  def test_printing
    # rws = RubyWifiScanner::LinuxScanner.new @mock_linux_scan
    rws = RubyWifiScanner::OSXScanner.new @mock_osx_scan
    puts rws.print_fmt
  end
end
