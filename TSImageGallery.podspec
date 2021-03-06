#
# Be sure to run `pod lib lint TSImageGallery.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TSImageGallery'
  s.version          = '0.1.0'
  s.summary          = 'TSImageGallery for Airlift Demo'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This includes images to be picked from Photo Library, URL and Assets, design is copied from Instagram\'s look and feel'
                       DESC

  s.homepage         = 'https://github.com/TalibDev/TSImageGallery'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Talib Shabbir Hussain' => 'talib.shabbir.hussain@gmail.com' }
  s.source           = { :git => 'https://github.com/TalibDev/TSImageGallery.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  s.source_files = 'Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'TSImageGallery' => ['TSImageGallery/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
