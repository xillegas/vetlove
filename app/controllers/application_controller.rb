class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: :errors_controller
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # Pundit: white-list approach.
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_authorized, except: [:index, :not_found, :internal_server_error], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  # def remote_ip
  #   if request.remote_ip == '127.0.0.1'
  #     # Hard coded remote address
  #     '123.45.67.89'
  #   else
  #     request.remote_ip
  #   end
  # end

  def after_sign_in_path_for(resource)
    if current_user.is_vet
      consulting_rooms_vet_path
    else
      consulting_rooms_user_path
    end
  end


  def remote_ip
    if Rails.env.production?
      request.remote_ip
    else
      URI.open('http://whatismyip.akamai.com').read
    end
  end

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  protected

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :is_vet, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
