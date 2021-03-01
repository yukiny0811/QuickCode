require 'bundler'
Bundler.require

require "sass"
require 'sass/plugin/rack'
use Sass::Plugin::Rack

require './app'
run Sinatra::Application