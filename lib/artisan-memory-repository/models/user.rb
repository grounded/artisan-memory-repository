require "artisan-memory-repository/models/base"
require "active_model"

module ArtisanMemoryRepository
  class User < ArtisanMemoryRepository::Base
    data_attributes :full_name, :projects, :members,
      :login, :email, :gravatar_url, :password,
      :password_confirmation

    def initialize(*args)
      @external_errors = []
      super(*args)
    end

    include ActiveModel::Validations

    validates :full_name, :presence => true
    validates_length_of :login, :minimum => 3
    validates_format_of :login, :with => /\A\w[\w\.+\-_@ ]+$/, :message => "should use only letters, numbers, spaces, and .-_@ please."

    validate do
      @external_errors.each { |error| errors.add *error }
      true
    end

    def add_error(*args)
      @external_errors << args
    end
  end
end
