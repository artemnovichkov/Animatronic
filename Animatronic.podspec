#
# Be sure to run `pod lib lint Animatronic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Animatronic'
  s.version          = '0.1.0'
  s.summary          = 'High-performance working with image animation in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/artemnovichkov/Animatronic'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Artem Novichkov' => 'artem.novichkov@rosberry.com' }
  s.source           = { :git => 'https://github.com/artemnovichkov/Animatronic.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Animatronic/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Animatronic' => ['Animatronic/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
