workspace 'wokestuffshop'
use_frameworks!

def shared_pods
  # Pods for wokestuffshop
    # Rx
    pod 'RxSwift',                              '~> 4.0'
    pod 'RxCocoa',                              '~> 4.0'
    # Tools
    pod 'SwiftGen',                             '~> 4.2'
    pod 'Reusable',                             '~> 4.0'
    pod 'ActiveLabel',                          '~> 0.8.1'
    pod 'SnapKit',                              '~> 4.0.0'
    pod 'R.swift'
    pod 'Texture'
    pod 'Mobile-Buy-SDK'
    pod 'ObjectMapper', '~> 3.3'
end
    
  target 'App' do
    
      
      shared_pods
  end
target 'ShopifyKit' do
    project 'ShopifyKit/ShopifyKit'
    
    shared_pods
end

