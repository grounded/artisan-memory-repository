module ArtisanMemoryRepository

  module BaseRepository
    def save(object)
      clone = object.dup

      if clone.id
        records[clone.id] = clone
      else
        clone.id = records.size + 1
        records[clone.id] = clone
      end

      return clone
    end

    #def create!(attrs = {})
    #  project = model_class.new(attrs)
    #  self.save(project)
    #end

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
