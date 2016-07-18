require 'httparty'
require 'pry'

class MyApi
  include HTTParty
  base_uri "http://localhost:3000"

  def initialize email, password
    @email = email
    @password = password
  end

  def login
    resp = MyApi.post "/users/sign_in.json", #headers: headers,
    body: {
      user: {
        email: @email,
        password: @password,
        remember_me: 1
          }
        }
    binding.pry
  end
  private

  def headers
    {
      "Authorization" => "#{@email}:#{@password}",
      "Accept"        => "application/json"
    }
  end
end


print "What's your email? > "
email = gets.chomp

print "What's your password? > "
password = gets.chomp

api = MyApi.new email, password
api.login
