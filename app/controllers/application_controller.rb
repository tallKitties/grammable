class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def render_error(status=:not_found)
    render plain: "#{status.to_s.titleize}", status: status
  end
end
