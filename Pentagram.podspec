#
# Be sure to run `pod lib lint Pentagram.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Pentagram'
  s.version          = '1.1.0'
  s.summary          = 'Staff for use in music apps'


  s.description      = 'A music staff you can use on music education apps, music games, etc. Please feel free to contribute, report bugs or ask for features'

  s.homepage         = 'https://github.com/LucasCoelho/Pentagram'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Coelho' => 'lucas@coelho.be' }
  s.source           = { :git => 'https://github.com/LucasCoelho/Pentagram.git', :tag => '1.1.0' }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pentagram/Classes/**/*'
  
  s.resource_bundles = {
    'Pentagram' => ['Pentagram/**/*.xib']
#   'Pentagram' => ['Pentagram/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
