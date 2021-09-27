Pod::Spec.new do |s|
  s.name             = 'SPMenu'
  s.version          = '2.0.8'
  s.license          = 'MIT'
  s.summary          = 'Elegant Dropdown Menu in Swift'
  s.homepage         = 'https://github.com/comcxx11/SPMenu'
  s.author           = { 'comcxx11' => 'comcxx11@gmail.com' }
  s.source           = { :git => 'https://github.com/comcxx11/SPMenu.git', :tag => s.version.to_s }
  s.swift_versions   = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5']
  # s.documentation_url = 'https://'
  
  s.ios.deployment_target = '10.0'
  # s.osx.deployment_target = '10.12'
  # s.tvos.deployment_target = '10.0'
  # s.watchos.deployment_target = '3.0'
  
  s.source_files = 'SPMenu/Classes/**/*'
  s.dependency 'SnapKit'
  # s.frameworks = 'CFNetwork'
end
