require 'rubygems'
require 'bundler/setup'
require "hyperresource"
require 'highline/import'
require "./lib/auth.rb"
require "./lib/lists.rb"
require "./lib/todos.rb"

api = HyperResource.new(root: 'http://localhost:3306',
                    headers: {'Accept' => 'application/hal+json'})
root = api.get
cookie = CGI::Cookie::parse root.get_response.headers["set-cookie"]
session_cookie = /^[^;]+/.match(cookie["rack.session"].value.to_s)

root.headers = {'Accept' => 'application/hal+json', 'Cookie' => "#{session_cookie}"}

user = nil

choose do |menu|
    say "===================="
    
    menu.prompt = "Login or register  "
    menu.choice(:login) { user = login root }
    menu.choice(:register) { user = register root }
end


lists user
