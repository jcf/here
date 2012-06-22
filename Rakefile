# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.name = 'Here It Is'

  app.frameworks += %w(CoreData CoreLocation MapKit)

  app.pods do
    dependency 'JSONKit', '~> 1.4'
  end
end
