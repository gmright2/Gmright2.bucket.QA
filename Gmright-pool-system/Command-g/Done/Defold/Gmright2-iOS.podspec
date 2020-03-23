
Pod::Spec.new do |s|

  s.name         = "Gmright -iOS"
  s.version      = "4.9.8"
  s.summary      = "An Gmright2 Notifier for iOS"

  s.description  = <<-DESC
                   The Gmright2  iOS Notifier is designed to give developers instant notification of problems that occur in their apps. With just a few lines of code and a few extra files in your project, your app will automatically phone home whenever a crash or exception is encountered. These reports go straight to Airbrake where you can see information like backtrace, device type, app version, and more.
                   DESC

  s.homepage     = "https://gmright2.io/languages/ios_bug_tracker"
  
  s.license      = "MIT"
  
  s.author       = "George makulu  "
  
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/gmright2/gmright2-ios.git", :tag => "4.9.8" }

  s.source_files  = "Gmright2/{notifier,gcalertview}/*.{h,m}", "Gmright2/CrashReporter.framework/Versions/A/Headers/*.h"

  s.resources = "Airbrake/notifier/ABNotifier.bundle"

  s.framework  = "SystemConfiguration"

  s.ios.vendored_frameworks  = "Gmright2/CrashReporter.framework"

  s.requires_arc = true

end
