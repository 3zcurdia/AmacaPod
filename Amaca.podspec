Pod::Spec.new do |s|
  s.name             = 'Amaca'
  s.version          = '0.1.3'
  s.summary          = 'A restful network interface'
  s.description      = 'Multipropuse Network iterface for RESTful services with Codable objects'

  s.homepage         = 'https://github.com/3zcurdia/amaca'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Luis Ezcurdia' => 'ing.ezcurdia@gmail.com' }
  s.source           = { git: 'https://github.com/3zcurdia/Amaca.git', tag: s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '11.0'
  # s.osx.deployment_target  = '10.10'

  s.source_files = 'Amaca/Classes/**/*'
end
