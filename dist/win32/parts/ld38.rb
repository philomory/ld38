#!/usr/bin/env ruby

require 'gosu'
require 'require_all'
require 'crack'

APP_ROOT = File.dirname(__FILE__)
SOURCE_ROOT = File.join(APP_ROOT,'src')
MEDIA_ROOT = File.join(APP_ROOT,'media')
DATA_ROOT = File.join(APP_ROOT,'data')

require_all File.join(File.dirname(__FILE__),'src')

Game.play!