require 'artisan-memory-repository/base_repository'
require 'artisan-memory-repository/models/change'

module ArtisanMemoryRepository
  class ChangeRepository
    include BaseRepository
    
    def model_class
      ArtisanMemoryRepository::Change
    end
    
    def create_project_change(attributes = {})
      create(attributes.merge({:type => "ProjectChange"}))
    end
    
    def create_iteration_change(attributes = {})
      create(attributes.merge({:type => "IterationChange"}))
    end
    
    
    def create_story_change(attributes = {})
      create(attributes.merge({:type => "StoryChange"}))
    end
    
    
    def find_all_by_project_id(project_id)
      records.values.find_all {|r| r.project_id == project_id}.sort_by(&:created_at).reverse
    end
    
  end
end
