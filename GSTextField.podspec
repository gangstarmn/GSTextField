 Pod::Spec.new do |s|
  s.name         = "GSTextField"
  s.version      = "0.1.7"
  s.summary      = "GSTextField is a error view with UITextField"
  s.description  = <<-DESC
                    Алдаа харуулдаг, Мөн алдааны мэссэж харуулдаг UITextfield.
                   DESC
  s.homepage     = "https://github.com/gangstarmn/GSTextField"
  s.license      = "MIT"
  s.author             = { "Gantulga" => "gangstarmn@gmail.com" }
  s.platform = :ios, '8.0'
  s.source = { :git => 'https://github.com/gangstarmn/GSTextField.git', :tag => "#{s.version}" }

  s.source_files = "GSTextField/**/*.{h,m}"

  s.resources = "GSTextField/**/*.{xib,xcassets,bundle}"

  s.framework = 'UIKit'
  s.requires_arc = true

  s.dependency 'GSLocalization'
  s.dependency 'InputValidators'
  s.dependency 'SCViewShaker'
  end
