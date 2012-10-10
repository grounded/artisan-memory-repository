module ArtisanMemoryRepository
  class Base
    def initialize(options = {})
      self.class._collections.each {|field| set(field, [])}
      options.each { |key, value| set(key, value) }
      set(:id, random_int) if saves?
      self.init
    end

    def init; end

    def self.data_attributes(*fields)
      @_fields = fields
      (fields + [:id, :saves]).each {|field| attr_accessor field }
    end

    def self._fields
      @_fields ||= []
    end

    def self.boolean(*fields)
      (fields).each do |field|
        define_method("#{field}?".to_sym) { !!get(field) }
      end
    end

    def self.collections(*collections)
      @_collections = collections
      collections.each do |collection|
        attr_accessor collection
      end
    end

    def self._collections
      @_collections ||= []
    end

    def saves?
      get(:saves).nil? ? true : !!get(:saves)
    end

    def get(key)
      instance_variable_get("@#{key}")
    end

    def set(key, value)
      instance_variable_set("@#{key}", value)
    end

    def attributes
      self.class._fields.inject({}) do |attributes, key|
        attributes[key] = get(key)
        attributes
      end
    end

    alias :update_attribute :set

    def update_attributes(options = {})
      return false unless saves?
      return attributes if options.nil?
      options.each { |key, value| set(key, value) }
    end

    alias :update_attributes! :update_attributes

    def ==(other)
      return false if other.nil?
      return false if other.class != self.class
      self.class._fields.each do |attr|
        return false if self.send(attr) != other.send(attr)
      end
    end

    def to_param
      id.to_s
    end

    private

    def random_int
      return (Time.now.to_i + rand(1000))
    end
  end
end
