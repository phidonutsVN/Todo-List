class User < ApplicationRecord
  has_secure_password
  has_many :categories, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "không đúng định dạng" }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
