Pod::Spec.new do |spec|

  spec.name         = "AppFoundation"
  spec.version      = "0.0.1"
  spec.summary      = "AppFoundation"

  spec.license      = "CCNS"
  spec.author       = {
    "Aleksander Dainiak" => "dainiak@icloud.com"
  }
  
  spec.platform               = :ios
  spec.ios.deployment_target  = '13.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source = { :git => "" }
  spec.homepage     = "google.com"
  spec.source_files = "**/*.{swift,h,m}"
  spec.exclude_files = "**/*.podspec"
  
end
