Pod::Spec.new do |s|
s.name             = "NSManagedObject-HYPAttribute"
s.version          = "0.2"
s.summary          = "Helpers for evaluating a NSManagedObject's attribute"
s.homepage         = "https://github.com/hyperoslo/NSManagedObject-HYPAttribute"
s.license          = 'MIT'
s.author           = { "Hyper AS" => "teknologi@hyper.no" }
s.source           = { :git => "https://github.com/hyperoslo/NSManagedObject-HYPAttribute.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/hyperoslo'

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'Source/**/*'

s.frameworks = 'CoreData'
end
