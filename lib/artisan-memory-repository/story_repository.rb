require 'artisan-memory-repository/base_repository'
require 'artisan-memory-repository/models/story'

module ArtisanMemoryRepository
  class StoryRepository
    include BaseRepository

    def model_class
      ArtisanMemoryRepository::Story
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def find(number, project)
      result = records.values.find do |record|
        record.project == project && record.number == number
      end

      raise Artisan::RecordNotFound.new if result.nil?
      return result
    end

    def create!(attributes = {})
      save model_class.new(attributes)
    end

    def for_user(user)
      records.values.select{|r| r.assigned_user == user}
    end

    def by_project(project)
      records.values.select{|r| r.project.nil? ? false : r.project.id == project.id }
    end

    def create_for_project(project, attrs = {})
      story = create(attrs)
      project.stories << story
      story.project = project
      Artisan::Repository.project.save(project)
      story
    end

    def add_to_iteration(iteration, story)
      iteration.stories.delete_if { |s| s.id == story.id }
      iteration.stories << story
      story.iteration = iteration
      Artisan::Repository.iteration.save(iteration)
    end

    def remove_from_iteration(story)
      iteration = story.iteration
      story.iteration = nil
      iteration.stories.delete_if { |s| s.id == story.id }
    end

    def delete(story)
      deleted = records.delete(story.id)
      deleted.deleted = true
      deleted
    end

    def all(iteration)
      iteration.stories
    end

    def ready(iteration)
      iteration.stories.select{|r| r.assigned_user.nil? && !r.complete}
    end

    def working(iteration)
      iteration.stories.select{|r| !r.assigned_user.nil? &&
        !r.complete}
    end

    def completed(iteration)
      iteration.stories.select(&:complete)
    end

    def backlog(project)
      records.values.select { |r| r.iteration.nil? }
    end
  end
end

