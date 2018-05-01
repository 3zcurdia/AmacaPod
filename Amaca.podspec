Pod::Spec.new do |s|
  s.name             = 'Amaca'
  s.version          = '0.1.1'
  s.summary          = 'A restful network interface'
  s.description      = 'Multipropuse Network iterface for RESTful services with Codable objects'

  s.homepage         = 'https://github.com/3zcurdia/amaca'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Luis Ezcurdia' => 'ing.ezcurdia@gmail.com' }
  s.source           = { git: 'https://github.com/3zcurdia/Amaca.git', tag:s.version.to_s }

  s.swift_version = '4.0'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.10'

  s.source_files = 'Amaca/Classes/**/*'

  # s.resource_bundles = {
  #   'Amaca' => ['Amaca/Assets/*.png']
  # }
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '${PODS_TARGET_SRCROOT}/CCommonCrypto/' }
  s.preserve_paths = 'CCommonCrypto/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
