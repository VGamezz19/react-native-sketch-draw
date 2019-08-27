require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "react-native-sketch-draw"
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']

  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platforms    = { :ios => "9.0", :tvos => "9.2" }

  s.source       = { :git => "https://github.com/VGamezz19/react-native-sketch-draw.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m}"
  s.resources = ["ios/SketchView/SketchViewContainer.xib"]

  s.dependency 'React'
end