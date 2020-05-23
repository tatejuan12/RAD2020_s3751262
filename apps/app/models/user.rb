class User < ApplicationRecord
    has_many:cards
    attr_accessor :remember_token
    before_save {self.email=email.downcase }
    before_save {self.username=username.downcase }
    validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: { case_sensitive: false }
    VALID_MOBILE_REGEX = /\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}/
    validates :mobile, presence: true, format: { with: VALID_MOBILE_REGEX }, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password

    # return the hash digest of the given string
    def User.digest(string)     
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :   
                                                      BCrypt::Engine.cost     
        BCrypt::Password.create(string, cost: cost)   
    end

    # return a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remember a user in the database for use in persistent sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest,nil)
    end

end
