s.name         = "GSTextField"
  s.version      = "0.0.1"
  s.summary      = "GSTextField is a error view with UITextField"
  s.description  = <<-DESC
                    Thanks man.
                   DESC
  s.homepage     = "https://github.com/gangstarmn/GSTextField"
  s.license      = "MIT"
  s.author             = { "Gantulga" => "gangstarmn@gmail.com" }
  s.platform = :ios, '8.0'
  s.source = { :git => 'hhttps://github.com/gangstarmn/GSTextField.git', :tag => '0.0.1' }
  
  s.source_files = "GSTextField/**/*.{h,m}"
  
  s.resources = "GSTextField/**/*.{xib,xcassets}"
  
  s.framework = 'UIKit'
  s.requires_arc = true
  s.dependency 'InputValidators'