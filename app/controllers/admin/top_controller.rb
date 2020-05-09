class Admin::TopController < Admin::Base
  def index
    if current_administrator
      render action: "dashboard"
    else
      render
    end
  end
end
