require 'zip'
require 'version'
require 'rake/version_task'
require 'httparty'
require 'json'

Rake::VersionTask.new do |task|
  task.with_hg_tag = true
end

directory "dist"
directory "dist/releases"

directory "dist/macos"
directory "dist/macos/build"
MAC_BUILD_PATH = 'dist/macos/build'
RESOURCES_PATH = File.join(MAC_BUILD_PATH,'Strangeness.app/Contents/Resources/')

directory 'dist/win32'
directory 'dist/win32/build'
directory 'dist/win32/build/Strangeness'
WIN_BUILD_PATH = 'dist/win32/build/Strangeness'

namespace :clean do

  task :mac do
    rm_r MAC_BUILD_PATH if File.exists?('dist/macos/build')
  end
  
  task :win do
    rm_r WIN_BUILD_PATH if File.exists?('dist/win32/build')
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
    cp 'LICENSE', File.join(MAC_BUILD_PATH,"LICENSE.txt")
    cp 'README.md', File.join(MAC_BUILD_PATH,"README.txt")
  end
  
  desc "Windows Build"
  task :win => ['clean:win', 'dist/win32/build/Strangeness', 'dist/win32/parts/ruby.zip'] do
    Zip::File.foreach('dist/win32/parts/ruby.zip') {|f| f.extract File.join(WIN_BUILD_PATH,f.name) }
    cp 'dist/win32/parts/ld38.rb', WIN_BUILD_PATH
    cp 'dist/win32/parts/Strangeness.bat', WIN_BUILD_PATH
    cp_r 'src', WIN_BUILD_PATH
    cp_r 'data', WIN_BUILD_PATH
    cp_r 'media', WIN_BUILD_PATH
    cp 'LICENSE', File.join(WIN_BUILD_PATH,"LICENSE.txt")
    cp 'README.md', File.join(WIN_BUILD_PATH,"README.txt")
  end
end


namespace :release do
  namespace :check do
    task :mac do
      released_version = JSON.parse(HTTParty.get("https://itch.io/api/1/x/wharf/latest?target=philomory/strangeness&channel_name=macos").body)
      p released_version
      p Version.current
      raise "#{Version.current} already released for MacOS" if released_version == Version.current
    end
    
    task :win do
      released_version = JSON.parse(HTTParty.get("https://itch.io/api/1/x/wharf/latest?target=philomory/strangeness&channel_name=win32").body)
      raise "#{Version.current} already released for Windows" if released_version == Version.current
    end
  end
  
  namespace :zip do
    desc "MacOS Release"
    task :mac => ['check:mac', 'build:mac', 'dist/releases'] do
      Dir.chdir('dist/macos/build') do
        sh %[zip -r ../../releases/strangeness-macos-#{Version.current}.zip *]
      end
    end
  
    desc "Windows Release"
    task :win => ['check:win', 'build:win', 'dist/releases'] do
      Dir.chdir('dist/win32/build') do
        sh %[zip -r ../../releases/strangeness-win32-#{Version.current}.zip Strangeness]
      end
    end
  end
  
  desc "Create all zips"
  task :zip => ['zip:mac', 'zip:win']
  
  namespace :itch do
    desc "Publish Mac to itch.io"
    task :mac => 'release:zip:mac' do
      cp 'dist/macos/.itch.toml', MAC_BUILD_PATH
      #sh %[butler push --userversion-file=VERSION --fix-permissions dist/releases/strangeness-macos-#{Version.current}.zip philomory/strangeness:macos]
      sh %[butler push --userversion-file=VERSION --fix-permissions #{MAC_BUILD_PATH} philomory/strangeness:macos]
    end
    
    desc "Publish Win to itch.io"
    task :win => 'release:zip:win' do
      cp 'dist/win32/.itch.toml', WIN_BUILD_PATH
      #sh %[butler push --userversion-file=VERSION --fix-permissions dist/releases/strangeness-win32-#{Version.current}.zip philomory/strangeness:win32]
      sh %[butler push --userversion-file=VERSION --fix-permissions #{WIN_BUILD_PATH} philomory/strangeness:win32]
    end
  end
  
  task :itch => ['itch:mac','itch:win']
  
end

desc "Create all zip releases and push to itch.io"
task :release => 'release:itch'

desc "Check Butler status"
task :status do
  sh "butler status philomory/strangeness"
end
