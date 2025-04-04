require 'active_record'

module ActiveBuddy
  class Analyzer
    EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/
    PHONE_REGEX = /\A\+?[0-9]{7,15}\z/

    def initialize(model_class)
      @model = model_class
      @columns = model_class.columns
      @reflections = model_class.reflect_on_all_associations
    end

    def suggest_validations
      suggestions = []

      @columns.each do |col|
        name = col.name
        type = col.type
        null = col.null

        case name
        when /email/
          suggestions << "validates :#{name}, format: { with: #{EMAIL_REGEX.inspect} }"
          suggestions << "validates :#{name}, presence: true"
          suggestions << "validates :#{name}, uniqueness: true"
        when /phone|mobile|contact/
          suggestions << "validates :#{name}, format: { with: #{PHONE_REGEX.inspect} }"
        when /password/
          suggestions << "validates :#{name}, length: { minimum: 6 }"
        when /name|title/
          suggestions << "validates :#{name}, presence: true"
          suggestions << "validates :#{name}, length: { minimum: 2, maximum: 50 }"
        when /bio|description|summary|notes/
          suggestions << "validates :#{name}, length: { maximum: 1000 }"
        when /price|amount|cost|total|balance|fee/
          suggestions << "validates :#{name}, numericality: { greater_than_or_equal_to: 0 }"
        when /age|count|quantity|number|size/
          suggestions << "validates :#{name}, numericality: { only_integer: true, greater_than_or_equal_to: 0 }"
        when /status|role|type|category/
          suggestions << "validates :#{name}, presence: true"
        end

        suggestions << "validates :#{name}, presence: true" if !null && !name.match?(/id|_at$/)
      end

      suggestions.uniq.sort
    end

    def suggest_associations
      @reflections.map do |assoc|
        "#{assoc.macro} :#{assoc.name}"
      end
    end
  end
end
