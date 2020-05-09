Rails.application.configure do
  config.hosts << "example.com"
  config.hosts << "baukis2.example.com"
  config.hosts << "alb-main-727819637.ap-northeast-1.elb.amazonaws.com"
end
