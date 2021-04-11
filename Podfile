source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
use_frameworks!

platform :ios, '11.0'

# Rx
pod 'RxSwift', '~> 5'
pod 'RxCocoa'

# Architecture
pod 'RIBs', git: 'https://github.com/uber/RIBs', tag: 'v0.10.1'

# UI
pod 'SnapKit'

# Convenience
pod 'Then'

def testable_target(name)
  target name do
    yield if block_given?
  end

  target "#{name}Tests" do
    pod 'Quick', binary: true
    pod 'Nimble', binary: true
    pod 'RxTest', binary: true
  end
end

testable_target 'TicTacToe'

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |build_config|
      build_config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'

      if build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
        build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
