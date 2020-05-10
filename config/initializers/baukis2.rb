Rails.application.configure do
  config.baukis2 = if Rails.env.development?
                     {
                       staff: { host: "baukis2.example.com", path: "" },
                       admin: { host: "baukis2.example.com", path: "admin" },
                       customer: { host: "example.com", path: "mypage" }
                     }
                   else
                     {
                       staff: { host: "alb-main-727819637.ap-northeast-1.elb.amazonaws.com", path: "" },
                       admin: { host: "alb-main-727819637.ap-northeast-1.elb.amazonaws.com", path: "admin" },
                       customer: { host: "alb-main-727819637.ap-northeast-1.elb.amazonaws.com", path: "mypage" }
                     }
                   end
end
