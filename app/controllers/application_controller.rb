# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from StandardError, with: :dispatch_error unless Rails.env.development?

  def dispatch_error(exception)
    case exception
    when ActiveRecord::RecordNotFound, ActionController::RoutingError
      render_404(exception)
    else
      render_500(exception)
    end
  end

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception} #{exception.message}"
    end
    render template: "errors/error_404", status: :not_found, layout: "application"
  end

  def render_500(exception = nil)
    if exception
      logger.error "Rendering 500 with exception: #{exception.inspect}"
    end
    render template: "errors/error_500", status: :internal_server_error, layout: "application"
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end
end
