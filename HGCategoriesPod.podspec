#
# Be sure to run `pod lib lint HGCategoriesPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HGCategoriesPod'
  s.version          = '0.1.0'
  s.summary          = '类别库.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'HG-IOS类别库'

  s.homepage         = 'https://github.com/kennthsHG/HGCategoriesPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '黄 纲' => '362168751@qq.com' }
  s.source           = { :git => 'https://github.com/kennthsHG/HGCategoriesPod.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'HGCategoriesPod/Classes/**/*'
  
end
