class HomeController < ApplicationController
  require 'github/markup'
  skip_before_action :authenticate_user!

  def readme
    @html = GitHub::Markup.render('README.md', File.read("README.md"))
  end

end
