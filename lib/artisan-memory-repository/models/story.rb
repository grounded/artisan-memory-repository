require "artisan-memory-repository/models/base"

module ArtisanMemoryRepository
  class Story < Base

    data_attributes :assigned_user_id, :billed,
      :complete, :completed_at, :created_at, :creator,
      :creator_id, :deleted, :estimate, :incomplete, :name,
      :number, :nonbillable, :optimistic, :pessimistic,
      :position, :realistic, :standard_deviation, :tags,
      :tag_list, :assigned_user, :iteration, :project

    boolean :complete, :nonbillable, :deleted

    def to_json(*args)
      attributes.to_json
    end

    def valid?
      true
    end
  end
end
