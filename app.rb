require "rubygems"
require "bundler/setup"
require "multi_json"
require "hyperresource"
require "highline/import"
require "./lib/auth.rb"
require "./lib/lists.rb"
require "./lib/todos.rb"
require "./lib/tags.rb"

api = HyperResource.new(root: "http://localhost:3306",
                    headers: {"Accept" => "application/hal+json"})
root = api.get
cookie = CGI::Cookie::parse root.get_response.headers["set-cookie"]
session_cookie = /^[^;]+/.match(cookie["rack.session"].value.to_s)

root.headers = {"Accept" => "application/hal+json", "Cookie" => "#{session_cookie}"}


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

lists user
