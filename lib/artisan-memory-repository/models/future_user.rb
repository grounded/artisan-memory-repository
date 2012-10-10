require "artisan-memory-repository/models/base"

module ArtisanMemoryRepository
  class FutureUser < Base
    data_attributes :id, :email, :project_id, :login

    attr_reader :errors

    def init
      @errors = {}
    end

    def add_errors(errors_hash)
      errors_hash.each_pair do |key, value|
        @errors[key] = @errors[key] || []
        @errors[key] << value
      end
    end

  end
end
