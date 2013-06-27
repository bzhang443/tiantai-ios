# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

require 'rubygems'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TianTai'
  app.icons = %w(Icon.png Icon@2x.png)
  app.version = '1.0'
  app.deployment_target = '6.1'
  app.info_plist['CFBundleDisplayName'] = '天泰温泉'

  app.pods do
    pod 'Reachability'
    pod 'SVPullToRefresh'
    pod 'QuadCurveMenu'
    #pod 'UIKitHelper'
    pod 'TPKeyboardAvoiding'
  end

  app.provisioning_profile = 'team.mobileprovision'
  app.codesign_certificate = 'Bison Zhang'
  app.identifier = 'com.golftime.tiantai'

  app.development do
    app.entitlements['get-task-allow'] = true
  end

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = 'aca2eee2966c47b6c03b6309b1847dac_NTM1NTI0MjAxMi0wNy0xNiAxMToxMzoxOC4wMzM2NDM'
  app.testflight.team_token = '9f13c5e133f3ebf02f7781e9819be27f_MTEwNzE2MjAxMi0wNy0xNiAxMToxNzozNi43MzY0NzU'
end
