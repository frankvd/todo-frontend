require "rubygems"
require "bundler/setup"
require "multi_json"
require "active_support/all"
require "hyperresource"
require "highline/import"
require "./lib/auth.rb"
require "./lib/lists.rb"
require "./lib/todos.rb"
require "./lib/tags.rb"

if !ENV["host"].present? then
    ENV["host"] = "http://localhost:8888"
end

api = HyperResource.new(root: ENV["host"],
                    headers: {"Accept" => "application/hal+json"})
root = api.get

# Grab session cookie
cookie = CGI::Cookie::parse root.get_response.headers["set-cookie"]
session_cookie = /^[^;]+/.match(cookie["rack.session"].value.to_s)
# Add cookie to headers
root.headers = {"Accept" => "application/hal+json", "Cookie" => "#{session_cookie}"}

# Ask the user to login or register until they succeed
def loginMenu(root)
    user = nil
    choose do |menu|
        say "===================="
        say "Login or register"
        say "===================="
        menu.choice(:login) { user = login root }
        menu.choice(:register) { user = register root }
    end

    if user == nil then
        user = loginMenu(root)
    end

    user
end

user = loginMenu(root)

# Display the user's lists
lists user
