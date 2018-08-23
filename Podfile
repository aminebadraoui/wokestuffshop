workspace 'wokestuffshop'
use_frameworks!

def shared_pods
  # Pods for wokestuffshop
    # Rx
    pod 'RxSwift',                              '~> 4.0'
    pod 'RxCocoa',                              '~> 4.0'
    # Tools
    pod 'Reusable',                             '~> 4.0'
    pod 'SnapKit',                              '~> 4.0.0'
    pod 'R.swift'
    pod 'Texture'
    pod 'Mobile-Buy-SDK'
    pod 'AlamofireImage',                       '~> 3.3'
end
    
  target 'App' do
    
      
      shared_pods
  end
target 'ShopifyKit' do
    project 'ShopifyKit/ShopifyKit'
    
    shared_pods
end

