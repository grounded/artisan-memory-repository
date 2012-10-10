require 'artisan-memory-repository/models/project_configuration'

module ArtisanMemoryRepository
  class ProjectConfigurationRepository
    include BaseRepository

    def model_class
      ArtisanMemoryRepository::ProjectConfiguration
    end

    def new(attributes = {})
      model_class.new(attributes)
    end
  end
end
