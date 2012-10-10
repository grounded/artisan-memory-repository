require 'artisan-memory-repository/models/member'

module ArtisanMemoryRepository
  class MemberRepository
    def model_name
      Member
    end

    def new(attributes = {})
      model_name.new(attributes)
    end
  end
end
