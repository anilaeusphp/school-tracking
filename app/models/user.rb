class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable,
         :lockable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]
    
   include Roleable


         def self.from_omniauth(access_token)
          data = access_token.info
          user = User.where(email: data['email']).first


          unless user
           user = User.create(email: data['email'],
               email: data['email'],
               password: Devise.friendly_token[0,20]
              )
          end

          user.uid = access_token.uid
          user.provider = access_token.provider
          user.name = access_token.info.name
          user.image = access_token.info.image
          user.save

          user.confirmed_at = Time.now
          user
      end
      after_create do
        self.update(student: true)
      end

end
