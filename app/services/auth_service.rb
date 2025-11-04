# app/services/auth_service.rb
class AuthService
  def self.login(email:, password:)
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password)
    user
  end
end
