require "artisan-memory-repository/models/base"

module ArtisanMemoryRepository
  class Change < Base
    data_attributes :type, 
                    :source_id, 
                    :user_id, 
                    :event, 
                    :project_id, 
                    :created_at,
                    :original_fields,
                    :changed_fields
                    
  end
end
