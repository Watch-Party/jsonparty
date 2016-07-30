class HomeController < ApplicationController
  require 'github/markup'

  def readme
    @html = GitHub::Markup.render('README.md', File.read("README.md"))
  end

end
