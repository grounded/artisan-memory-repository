require 'artisan/repository'
require 'artisan-memory-repository/models/user'

module Memory
  module UserFactory
    def self.build(opts = {})
      ArtisanMemoryRepository::User.new(
        :full_name => opts[:full_name] || "Test User",
        :projects => opts[:projects] || [],
        :members => opts[:members] || [],
        :login => opts[:login] || "test",
        :email => opts[:email] || "test@user.com",
        :gravatar_url => opts[:gravatar_url] || "",
        :password => opts[:password] || "password",
        :password_confirmation => opts[:password_confirmation] || "password")
    end

    def self.create(opts = {})
      record = Memory::UserFactory.build(opts)
      Artisan::Repository.user.save(record)
      record
    end
  end
end
