# -*- coding: utf-8 -*-
$:.unshift '/Library/RubyMotion/lib'

require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.name = 'Here It Is'
  app.frameworks += %w(CoreData CoreLocation MapKit)

  app.files_dependencies(
    'app/controllers/location_list_view_controller.rb' => 'app/locateable.rb'
  )
end

namespace :sb do
  desc 'Open Xcode project'
  task :open do
    exec 'open', 'Locations/Locations.xcodeproj'
  end

  desc 'Edit storyboard'
  task :edit do
    target = ENV['target'] || 'iPhone'
    exec 'open', "Locations/Locations/en.lproj/MainStoryboard_#{target}.storyboard"
  end

  desc 'Replace storyboards in resources with those in the embedded Xcode project'
  task :update do
    FileUtils.cp(Dir['Locations/Locations/en.lproj/*.storyboard'], 'resources/')
  end
end
