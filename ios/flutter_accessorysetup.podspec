#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_accessorysetup.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_accessorysetup'
  s.version          = '0.0.1'
  s.summary          = 'A bridge for AccessorySetupKit for Flutter.'
  s.description      = <<-DESC
A bridge for AccessorySetupKit for Flutter.
                       DESC
  s.homepage         = 'https://withintent.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Intent' => 'growth@withintent.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.frameworks = ['CoreBluetooth', 'AccessorySetupKit']
  s.platform = :ios, '18.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.10'
end
