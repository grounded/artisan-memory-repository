require 'artisan-memory-repository/base_repository'
require 'artisan-memory-repository/models/project'
require "artisan-memory-repository/models/project_configuration"

module ArtisanMemoryRepository
  class ProjectRepository
    include BaseRepository

    def model_class
      ArtisanMemoryRepository::Project
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def order_by_name
      records.values.sort_by { |r| r.name }
    end

    def unarchived
      records.values.select { |r| !r.archived  }.sort_by(&:name)
    end

    def archived
      records.values.select { |r| r.archived  }.sort_by(&:name)
    end

    def find_by_api_key(api_key)
      records.values.find { |r| r.api_key == api_key }
    end

    def find_by_name(name)
      records.values.find{|r| r.name == name}
    end

    def add_iteration(project, iteration)
      project.iterations << iteration
      project.iterations.sort! { |i| i.number }
      iteration
    end

    def add_member(project, user, owner)
      project.users << user
      project.owners << user if owner
    end

    def remove_member(project, user)
      project.users.delete(user)
      project.owners.delete(user)
    end

    def is_member?(project, user)
      project.users.include?(user)
    end

    def is_owner?(project, user)
      project.owners.include?(user)
    end

    def owners(project)
      project.owners
    end

    def create_project_configuration(project)
      project.project_configuration = ArtisanMemoryRepository::ProjectConfiguration.new
    end
  end
end

