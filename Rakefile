# -*- coding: utf-8 -*-
$:.unshift '/Library/RubyMotion/lib'

require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.name = 'Here It Is'
  app.frameworks += %w(CoreData CoreLocation MapKit)
end

desc 'Replace storyboards in resources with those in the embedded Xcode project'
task :update_storyboards do
  FileUtils.cp(Dir['Locations/Locations/en.lproj/*.storyboard'], 'resources/')
end
