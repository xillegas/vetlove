class MainController < ApplicationController
  layout 'main'

  def dashboard
    skip_authorization
  end

end
