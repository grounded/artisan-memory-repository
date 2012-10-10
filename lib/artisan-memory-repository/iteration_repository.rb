require 'artisan-memory-repository/base_repository'
require 'artisan-memory-repository/models/iteration'

module ArtisanMemoryRepository
  class IterationRepository
    include BaseRepository

    def model_class
      ArtisanMemoryRepository::Iteration
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def create_for_project(project, attrs)
      iteration = model_class.new(attrs)
      iteration.project = project
      project.iterations << iteration
      save(iteration)
    end

    def find_by_number(project, number)
      records.values.find {|r| r.project == project && r.number = number}
    end

    def by_project(project, options = {})
      records.values.find_all {|r| r.project == project}.sort_by(&:number).reverse
    end

    def by_project_by_finish_date(project)
      self.by_project(project).sort_by!{ |iteration| Date.parse(iteration.finish_date) }.reverse
    end

  end
end
