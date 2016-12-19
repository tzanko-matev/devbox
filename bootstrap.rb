require 'rubygems'
require 'json'
require 'highline/import'

data = begin JSON.parse File.read("config.json") rescue {} end

default_username = data['username'] || nil

data['username'] = ask("Please, enter your username (#{default_username}): ")  do |q|
  q.default = default_username
end

default_fullname = begin 
  data['fullname'] || `git config user.name`.chomp
rescue
  nil
end

data['fullname'] = ask("Please, enter your full name (#{default_fullname}): ") do |q|
  q.default = default_fullname
end

default_email = begin
  data['email'] || `git config user.email`.chomp
rescue
  nil
end

data['email'] = ask("Please enter your email (#{default_email}): ") do |q|
  q.default = default_email
end

open("config.json", "w") { |f| f.puts JSON.pretty_generate(data)}
