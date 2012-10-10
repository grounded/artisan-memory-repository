require 'artisan-memory-repository/models/user'
require 'artisan-memory-repository/base_repository'

module ArtisanMemoryRepository
  class UserRepository
    include BaseRepository

    def new(attrs = {})
      ArtisanMemoryRepository::User.new(attrs)
    end

    def create(attrs = {})
      user = new(attrs)
      if !existing_login?(user.login) && user.valid?
        save(user)
      else
        user.add_error(:login, 'has already been taken')
        raise ArgumentError.new('The record has errors.')
      end
      user
    end

    def find_by_email(email)
      records.values.find { |r| r.email == email  }
    end

    def find_by_login(login)
      return nil if login.nil?
      records.values.find { |r| r.login.downcase == login.downcase  }
    end

    def active_stories_for(user)
      story_repository = Artisan::Repository.story
      stories = story_repository.for_user(user)
      stories.reject { |story| story.complete }
    end

    private

    def existing_login?(login)
      !find_by_login(login).nil?
    end
  end
end
