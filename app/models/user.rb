class User < ActiveRecord::Base
  has_secure_password
  validates_length_of :password, :minimum => 5
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  before_save { self.email = email.downcase }
  def authenticate_with_credentials(email, auth_password)
    email = email.strip.downcase
    puts "hellllloooooo #{email}"
    @user = User.find_by_email(email)
    if @user.authenticate(auth_password)
      @user
    else
      return nil
    end
  end
end
