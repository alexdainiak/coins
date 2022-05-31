### Sources

source 'https://github.com/CocoaPods/Specs.git'

### Plugins

plugin 'cocoapods-developing-folder'

### Setup

platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

install! 'cocoapods', :disable_input_output_paths => true, :preserve_pod_file_structure => true
use_folders :skip_top_level_group => ['Modules']
local_pod_searching_root 'Modules'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

### Pods

def main
  pod 'Swinject', '2.7.1'
  pod 'DifferenceKit'
  pod 'RxDataSources', '~> 4.0'
end

def networking
end

def core
  local_pod 'Coordinator'
  local_pod 'Network'
  local_pod 'AppFoundation'
  local_pod 'FeatureModule'
  local_pod 'UIComponents'
  local_pod 'CarbonKit'
end

def platform
  local_pod 'Data'
  local_pod 'Domain'
  local_pod 'Coordinators'
end

def features
  local_pod 'Dashboard'
end

### Targets

['Coins.ph'].each do |t|
  target t do
    core
    platform
    networking
    main
    features
  end
end

### Post Install

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'SESmartID' then
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_BITCODE'] = 'NO'
      end
    end
  end
end


target 'Coins.phTests' do
  main
  platform
  features
  pod 'RxBlocking'
  pod 'RxTest'
  pod 'Quick'
  pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest'], :inhibit_warnings => true
end
