class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member&.hashed_password &&
      @staff_member.start_date <= Time.zone.today &&
      (@staff_member.end_date.nil? || Time.zone.today < @staff_member.end_date) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end
