class CreateUserContract < Dry::Validation::Contract
  params do
    required(:username).filled(:string)
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
  end

  rule(:username) do
    key.failure("must be at least 3 characters") if value.length < 3
  end

  rule(:password) do
    key.failure("must be at least 6 characters") if value.length < 6
  end

  rule(:password, :password_confirmation) do
    if values[:password] != values[:password_confirmation]
      key(:password_confirmation).failure("does not match password")
    end
  end
end
