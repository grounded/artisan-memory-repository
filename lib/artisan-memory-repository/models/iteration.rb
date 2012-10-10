require "artisan-memory-repository/models/base"

module ArtisanMemoryRepository
  class Iteration < Base
    data_attributes :completed_total,
      :story_tags,
      :start_date,
      :finish_date,
      :number,
      :complete,
      :completed_at,
      :committed_points_at_completion,
      :errors,
      :total_billed_points,
      :committed_points,
      :total_points,
      :project,
      :days

    boolean :complete

    collections :stories, :users
  end
end
