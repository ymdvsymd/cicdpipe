Rails.application.configure do
  config.action_controller.permit_all_parameters = true
  config.action_controller.default_protect_from_forgery = true
end
