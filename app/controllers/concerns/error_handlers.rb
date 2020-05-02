module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private

    def rescue403(err)
      @exception = err
      render "errors/forbidden", status: :forbidden
    end

    def rescue404(err)
      render "errors/not_found", status: :not_found
    end

    def rescue500(err)
      render "errors/internal_server_error", status: :internal_server_error
    end
end
