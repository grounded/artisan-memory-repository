require 'artisan-memory-repository/models/future_user'
require 'artisan-memory-repository/base_repository'

module ArtisanMemoryRepository
  class FutureUserRepository
    include BaseRepository

    def new(attrs = {})
      ArtisanMemoryRepository::FutureUser.new(attrs)
    end

    def create(attrs = {})
      future_user = new(attrs)
      unique_email = validate_unique_email(attrs[:email])
      if unique_email
        save(future_user)
      else
        future_user.add_errors(:email => "This email has already been taken")
        raise ArgumentError.new('The record has errors.')
      end
      future_user
    end

    def find_by_email(email)
      records.values.find { |r| r.email == email }
    end

    def find_by_project_id(project_id)
      records.values.find { |r| r.project_id == project_id }
    end

    private

    def validate_unique_email(email)
      return false if email.nil?
      !records.values.any? { |r| r.email == email }
    end
  end
end
