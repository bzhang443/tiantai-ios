# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

require 'rubygems'
require 'bundler'
Bundler.require

require './lib/app_properties'
props = AppProperties.new

Motion::Project::App.setup do |app|
  app.name = 'TianTai'
  app.icons = %w(Icon.png Icon@2x.png)
  app.version = props.app_version
  app.short_version = props.app_version
  app.deployment_target = '6.0'
  app.interface_orientations = [:portrait]
  app.info_plist['CFBundleDisplayName'] = '天泰温泉'
  #app.info_plist['UILaunchImageFile'] = 'kaiji-1.jpg'  # smaller? can't get approved?
  app.files += Dir.glob("./lib/**/*.rb")

  app.pods do
    pod 'Reachability'
    pod 'SVPullToRefresh'
    pod 'QuadCurveMenu'
    pod 'ISPageScrollView'
    pod 'TPKeyboardAvoiding'
    pod 'CEPopupPickerView'
    pod 'SDWebImage'
  end

  app.identifier = props.app_identifier

  app.development do
    app.entitlements['get-task-allow'] = true
    app.provisioning_profile = props.development_app_provision
    app.codesign_certificate = props.development_app_codesign
  end
  app.release do
    app.provisioning_profile = props.release_app_provision
    app.codesign_certificate = props.release_app_codesign
  end
end
