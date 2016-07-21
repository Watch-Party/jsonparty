require 'httparty'
require 'pry'

class MyApi
  include HTTParty
  base_uri "http://localhost:3000/"

  def initialize email, password
    @email = email
    @password = password
  end

  def login
    resp = MyApi.post "/auth/sign_in", #headers: headers,
    body: {
        email: @email,
        password: @password,
        }
    binding.pry
  end

  def signup
    resp = MyApi.post "/auth", #headers: headers,
    body: {
        email: @email,
        password: @password,
        password_confirmation: @password,
        first_name: "Robert",
        last_name: "LaBlah",
        screen_name: "boblablah"
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


# print "What's your email? > "
email = "bob@example.com"

# print "What's your password? > "
password = "hunter2"

api = MyApi.new email, password
api.login
