#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint signalr_socket.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'signalr_socket'
  s.version          = '1.0.0'
  s.summary          = 'SignalR Socket'
  s.description      = <<-DESC
SignalR Socket
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'Alamofire', '~> 5.6'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
