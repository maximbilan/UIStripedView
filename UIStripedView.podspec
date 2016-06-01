Pod::Spec.new do |s|
	s.name         = "UIStripedView"
	s.version      = "0.2"
	s.summary      = "StripedView"
	s.description  = "UIStripedView - a UIView with striped lines effect"
	s.homepage     = "https://github.com/maximbilan/UIStripedView"
	s.license      = { :type => "MIT" }
	s.author       = { "Maxim Bilan" => "maximb.mail@gmail.com" }
	s.platform     = :ios, "6.0"
	s.source       = { :git => "https://github.com/maximbilan/UIStripedView.git", :tag => "0.2" }
	s.source_files  = "Classes", "UIStripedView/Sources/**/*.{h,m}"
	s.requires_arc = true
end