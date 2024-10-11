#
# Be sure to run `pod lib lint ImageFetchable' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  # pod lib lint
  # pod trunk push ValueX.podspec

  s.name             = 'ImageFetchable'
  s.version          = '2.1.2'
  s.summary          = 'A library to handle web image.'
  s.homepage = "https://github.com/xaoxuu/ImageFetchable"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { "xaoxuu" => "git@xaoxuu.com" }
  s.platform = :ios, "14.0"
  s.ios.deployment_target = '14.0'

  s.source = { :git => "https://github.com/xaoxuu/ImageFetchable.git", :tag => "#{s.version}", :submodules => true}

  s.source_files = 'Sources/**/*'
  
  s.swift_version = '5.10'

end
