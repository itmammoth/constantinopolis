require "constantinopolis/version"
require "yaml"
require "erb"

module Constantinopolis

  class Fort
    private_class_method :new

    class << self

      def yml(path = nil)
        @yml ||= path
      end

      def namespace(namespace = nil)
        @namespace ||= namespace
      end

      def build!
        instance.build_methods!
      end

      private

      def instance
        return @instance if @instance
        @instance = new
      end
    end

    def build_methods!
      @constants.each do |key, value|
        self.class.module_eval do
          sig = class << self; self; end
          sig.send :define_method, key, ->() { value }
        end
      end
    end

    private

    def initialize
      raise "Must locate yaml file!" unless self.class.yml
      file = open(self.class.yml).read
      hash = set_accessor(YAML.load(ERB.new(file).result))
      @constants = self.class.namespace ? hash[self.class.namespace.to_s] : hash
    end

    def set_accessor(hash)
      hash.each do |key, value|
        if value.is_a? Hash
          value.extend AccessableHash
          set_accessor value
        end
      end
    end
  end

  module AccessableHash
    def method_missing(name, *args, &block)
      key = name.to_s
      self.has_key?(key) ? self[key] : super
    end
  end
end
