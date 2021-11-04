class MainController < ApplicationController
  layout 'main'

  def dashboard
    skip_authorization
  end

  def configuration
    skip_authorization
  end

end
