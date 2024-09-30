module Creators
  class Base
    attr_accessor :record

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params
    end

    def success?
      record.errors.empty?
    end

    private

    def creation_contract
      raise NotImplementedError
    end

    def validate_params
      contract = creation_contract.new.call(@params.to_h.with_indifferent_access)
      return unless contract.failure?

      contract.errors.each do |error|
        record.errors.add(error.path.first, error.text)
      end
    end

    def create_record
      return if record.save

      record.errors.full_messages
    end
  end
end
