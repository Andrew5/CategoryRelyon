#
# Be sure to run `pod lib lint CategoryRelyon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CategoryRelyon'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CategoryRelyon.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/localhost3585@gmail.com/CategoryRelyon'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'localhost3585@gmail.com' => 'localhost3585@gmail.com' }
  s.source           = { :git => 'https://github.com/localhost3585@gmail.com/CategoryRelyon.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  
  s.subspec 'AllCategories' do |all|
#    c.source_files = 'CategoryRelyon/Classes/**/*'
    all.source_files = 'CategoryRelyon/Classes/DataCategory/**/*.{h,m}',
                     'CategoryRelyon/Classes/UICategory/**/*.{h,m}'
  end
    
  #  s.source_files = 'CategoryRelyon/Classes/**/*'
  s.subspec 'DataCategory' do |data|
    data.source_files = 'CategoryRelyon/Classes/DataCategory**/*',
                       'CategoryRelyon/Classes/code/**/*'
  end
  
  s.subspec 'UICategory' do |ui|
    ui.source_files = 'CategoryRelyon/Classes/UICategory/**/*',
                     'CategoryRelyon/Classes/code/**/*'
  end
  
  s.default_subspec = 'DataCategory'
  # s.resource_bundles = {
  #   'CategoryRelyon' => ['CategoryRelyon/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'SDWebImageWebPCoder'
  s.user_target_xcconfig = { "ENABLE_STRICT_CHECKING_OF_OBJC_MSGSEND_CALLS" => "NO" }

end
