Pod::Spec.new do |spec|
    spec.name           = "Animatronic"
    spec.version        = "0.1"
    spec.summary        = "lightweight working with image animation."

    spec.homepage       = "https://github.com/artemnovichkov/Animatronic"
    spec.license        = { type: 'MIT', file: 'LICENSE' }
    spec.authors        = { "Artem Novichkov" => 'novichkoff93@gmail.com' }
    spec.platform       = :ios
    spec.requires_arc   = true

    spec.ios.deployment_target  = '8.0'
    spec.source                 = { git: "https://github.com/Otbivnoe/Animatronic.git", tag: "#{spec.version}"}
    spec.source_files           = "Sources/*.{h,swift}"
end
