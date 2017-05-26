require 'zip'
require 'version'

directory "dist"
directory "dist/macos"
directory "dist/macos/build"

RESOURCES_PATH = 'dist/macos/build/Strangeness.app/Contents/Resources/'

task :clean_mac do
  rm_r 'dist/macos/build' if File.exists?('dist/macos/build')
end

desc "Mac Build"
task :build_mac => [:clean_mac, 'dist/macos/build','dist/macos/ruby-app/Wrapper.app'] do
  cp_r 'dist/macos/ruby-app/Wrapper.app', 'dist/macos/build/Strangeness.app'
  cp_r 'src', RESOURCES_PATH
  cp_r 'data', RESOURCES_PATH
  cp_r 'media', RESOURCES_PATH
  sh %[plutil -replace CFBundleShortVersionString -string "#{Version.current}" dist/macos/build/Strangeness.app/Contents/Info.plist ]
  sh %[plutil -replace CFBundleVersion -string "#{Version.current}.#{Time.now.to_i}" dist/macos/build/Strangeness.app/Contents/Info.plist ]
end

desc "Mac Zip"
task :zip_mac => :build_mac do
  raise NotImplementedError
end

directory 'dist/win32'
directory 'dist/win32/build'
directory 'dist/win32/build/Strangeness'
WIN_BUILD_PATH = 'dist/win32/build/Strangeness'

task :clean_win do
  rm_r 'dist/win32/build' if File.exists?('dist/win32/build')
end

desc "Windows Build"
task :build_win => [:clean_win, 'dist/win32/build/Strangeness', 'dist/win32/parts/ruby.zip'] do
  Zip::File.foreach('dist/win32/parts/ruby.zip') {|f| f.extract File.join('WIN_BUILD_PATH',f.name) }
  cp 'dist/win32/parts/ld38.rb', WIN_BUILD_PATH
  cp 'dist/win32/parts/Strangeness.bat', WIN_BUILD_PATH
  cp_r 'src', WIN_BUILD_PATH
  cp_r 'data', WIN_BUILD_PATH
  cp_r 'media', WIN_BUILD_PATH
end

