module Creators
  class UserCreator < Base
    def call
      @record = User.new(@params)

      validate_params
      return self unless record.errors.empty?

      create_record
      self
    end

    private

    def creation_contract
      CreateUserContract
    end
  end
end
