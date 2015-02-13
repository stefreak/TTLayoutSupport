#
# Be sure to run `pod lib lint TTLayoutSupport.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TTLayoutSupport"
  s.version          = "0.3.0"
  s.summary          = "Makes it possible to modify the topLayoutGuide and bottomLayoutGuide of any UIViewController"
#  s.description      = <<-DESC
#                       An optional longer description of TTLayoutSupport
#
#                       * Markdown format.
#                       * Don't worry about the indent, we strip it!
#                       DESC
  s.homepage         = "https://github.com/stefreak/TTLayoutSupport"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Steffen Neubauer" => "stefreak@googlemail.com" }
  s.source           = { :git => "https://github.com/stefreak/TTLayoutSupport.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stefreak'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'TTLayoutSupport' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
