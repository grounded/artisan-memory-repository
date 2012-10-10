require "artisan-memory-repository/models/base"

module ArtisanMemoryRepository
  class Project < Base
    data_attributes :id, :name, :life_cycle, :archived, :description,
      :api_key, :project_configuration

    boolean :archived

    collections :iterations, :stories, :members, :owners, :users

  end
end
