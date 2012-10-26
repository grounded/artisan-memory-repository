module ArtisanMemoryRepository

  module BaseRepository
    def save(object)
      object.id = records.size + 1 if object.id.nil?
      records[object.id] = object
    end

    def create(attrs = {})
      project = model_class.new(attrs)
      self.save(project)
    end

    def find(id)
      record = records[id.to_i]
      raise Artisan::RecordNotFound unless record
      record
    end

    def find_each(&block)
      records.each do |id, model|
        block.call(model)
      end
    end

    def delete(id)
      records.delete(id)
    end

    def destroy_all
      @records = {}
    end

    def records
      @records ||= {}
    end

    def where(attributes)
      records.values.select do |record|
        attributes.all? { |key, value| record.send(key) == value }
      end
    end
  end
end
