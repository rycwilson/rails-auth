class User < ActiveRecord::Base

  BCrypt::Engine.cost = 12

  # NOTE: The current Rails convention for validations is below
  # The validates_<whatever>_of convention is deprecated
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: "!password.nil?"

  # associations
  has_many :users_books
  has_many :books, through: :users_books

  def authenticate(unencrypted_password)
    secure_password = BCrypt::Password.new(self.password_digest)
    if secure_password == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    #raise scope of password to instance
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def password
    #get password, equivalent to `attr_reader :password`
    @password
  end

  def self.confirm(user_params)
    user = User.find_by(email: user_params[:email])
    user.authenticate(user_params[:password])
  end

end
