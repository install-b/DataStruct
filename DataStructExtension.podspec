#
# Be sure to run `pod lib lint DataStruct.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DataStructExtension'
  s.version          = '0.1.0'
  s.summary          = 'Extend some classic data strures with Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Swift Implementation for Classic Data Strucutures.
                       DESC

  s.homepage         = 'https://github.com/install-b/DataStruct'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shangenzhang' => 'zsg' }
  s.source           = { :git => 'https://github.com/install-b/DataStruct.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  
  s.swift_version = "4.2", "5.0", "5.1"
#  s.source_files = 'Classes/**/*.swift'
  s.subspec 'Queue' do |ss|
      ss.source_files = 'Classes/Queue/**/*.swift'
  end
  s.subspec 'Stack' do |ss|
      ss.source_files = 'Classes/Stack/**/*.swift'
  end
  
  s.subspec 'LinkList' do |ss|
      ss.source_files = 'Classes/LinkList/**/*.swift'
#      ss.dependency = 'DataStructExtension/Queue'
  end
  
  s.subspec 'BinaryTree' do |ss|
      ss.source_files = 'Classes/BinaryTree/**/*.swift'
  end
  

  s.subspec 'Hash' do |ss|
      ss.source_files = 'Classes/Hash/**/*.swift'
  end
  # s.resource_bundles = {
  #   'DataStruct' => ['DataStruct/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
