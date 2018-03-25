source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'

inhibit_all_warnings!
use_frameworks!

def common
    # Static analysis
    pod 'SwiftLint'

    # Code generation
    pod 'SwiftGen'
end

target 'BPPMobileTest' do
  common

  # View debugging
  pod 'Reveal-SDK', :configurations => ['Debug']
end

target 'BPPMobileTestTests' do
  common

  # Network stubs
  pod 'OHHTTPStubs/Swift'
end

target 'BPPMobileTestUITests' do
  common
end

