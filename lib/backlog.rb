require "backlog/version"

$:.unshift File.join(File.dirname(__FILE__))
module Backlog
  require 'backlog/api'
  require 'backlog/object'
  require 'backlog/client'
end
