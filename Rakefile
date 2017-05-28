require 'zip'
require 'version'
require 'rake/version_task'
Rake::VersionTask.new

directory "dist"
directory "dist/releases"

directory "dist/macos"
directory "dist/macos/build"
RESOURCES_PATH = 'dist/macos/build/Strangeness.app/Contents/Resources/'

directory 'dist/win32'
directory 'dist/win32/build'
directory 'dist/win32/build/Strangeness'
WIN_BUILD_PATH = 'dist/win32/build/Strangeness'

namespace :clean do

  task :mac do
    rm_r 'dist/macos/build' if File.exists?('dist/macos/build')
  end
  
  task :win do
    rm_r 'dist/win32/build' if File.exists?('dist/win32/build')
  end
  
end

task :clean => ['clean:mac', 'clean:win']


namespace :build do
  desc "Mac Build"
  task :mac => ['clean:mac', 'dist/macos/build','dist/macos/ruby-app/Wrapper.app'] do
    cp_r 'dist/macos/ruby-app/Wrapper.app', 'dist/macos/build/Strangeness.app'
    cp_r 'src', RESOURCES_PATH
    cp_r 'data', RESOURCES_PATH
    cp_r 'media', RESOURCES_PATH
    sh %[plutil -replace CFBundleShortVersionString -string "#{Version.current}" dist/macos/build/Strangeness.app/Contents/Info.plist ]
    sh %[plutil -replace CFBundleVersion -string "#{Version.current}.#{Time.now.to_i}" dist/macos/build/Strangeness.app/Contents/Info.plist ]
  end
  
  desc "Windows Build"
  task :win => ['clean:win', 'dist/win32/build/Strangeness', 'dist/win32/parts/ruby.zip'] do
    Zip::File.foreach('dist/win32/parts/ruby.zip') {|f| f.extract File.join(WIN_BUILD_PATH,f.name) }
    cp 'dist/win32/parts/ld38.rb', WIN_BUILD_PATH
    cp 'dist/win32/parts/Strangeness.bat', WIN_BUILD_PATH
    cp_r 'src', WIN_BUILD_PATH
    cp_r 'data', WIN_BUILD_PATH
    cp_r 'media', WIN_BUILD_PATH
  end
end


namespace :release do
  namespace :check do
    task :mac do
      raise if File.exist?("dist/releases/strangeness-macos-#{Version.current}.zip")
    end
    
    task :win do
      raise if File.exist?("dist/releases/strangeness-win32-#{Version.current}.zip")
    end
  end
  
  desc "MacOS Release"
  task :mac => ['check:mac', 'build:mac', 'dist/releases'] do
    Dir.chdir('dist/macos/build') do
      sh %[zip -r ../../releases/strangeness-macos-#{Version.current}.zip Strangeness.app]
    end
  end
  
  desc "Windows Release"
  task :win => ['check:win', 'build:win', 'dist/releases'] do
    Dir.chdir('dist/win32/build') do
      sh %[zip -r ../../releases/strangeness-win32-#{Version.current}.zip Strangeness]
    end
  end
  
end


task :release => ['release:mac', 'release:win']
