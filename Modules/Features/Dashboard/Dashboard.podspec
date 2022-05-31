Pod::Spec.new do |spec|

  spec.name         = "Dashboard"
  spec.version      = "0.0.1"
  spec.summary      = "Dashboard"

  spec.license      = "CCNS"
  spec.author       = { 
    "Aleksander Dainiak" => "dainiak@icloud.com"
}
  spec.platform               = :ios
  spec.ios.deployment_target  = '13.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.source = { :git => "" }
  
  spec.homepage = "google.com"
  
  spec.source_files = "**/*.swift"
  spec.exclude_files = "**/*.podspec"
  spec.resources = 'Resources/*'

  # ――― Dependencies ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  spec.dependency "FeatureModule"
  spec.dependency "Swinject"
  spec.dependency "Domain"
  spec.dependency "RxSwift"
  spec.dependency "RxCocoa"
  spec.dependency "CarbonKit"
  spec.dependency "UIComponents"
  
end

