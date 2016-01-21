class UserValidator < ActiveModel::Validator
  def validate(record)
    if record.should_validate
      unless record.email.present?
        record.errors[:email] << ' nie może być pusty!'
      end
      unless record.password.present?
        record.errors[:password] << ' musi zostać podane!'
      end
      unless record.password == record.password_confirmation
        record.errors[:password] << ' musi zgadzać się z potwierdzeniem!'
      end
      if User.find_by(email: record.email)
        record.errors[:email] << ' zajęty!'
      end
    end
  end
end