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
  app.version = '1.0'
  app.deployment_target = '6.0'
  app.interface_orientations = [:portrait]
  app.info_plist['CFBundleDisplayName'] = '天泰温泉'

  app.pods do
    pod 'Reachability'
    pod 'SVPullToRefresh'
    pod 'QuadCurveMenu'
    pod 'ISPageScrollView'
    pod 'TPKeyboardAvoiding'
    pod 'CEPopupPickerView'
    pod 'SDWebImage'
    pod 'MBProgressHUD'
  end

  app.provisioning_profile = 'team.mobileprovision'
  app.codesign_certificate = 'Bison Zhang'
  app.identifier = 'com.golftime.tiantai'

  app.development do
    app.entitlements['get-task-allow'] = true
  end

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = props.testflight_apitoken
  app.testflight.team_token = props.testflight_teamtoken
end
