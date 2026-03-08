module Mulukhiya
  module Rubicure
    class Girl
      attr_reader :key

      def initialize(record)
        @record = record
        @key = record[:key]
      end

      def precure_name = @record[:cure_name]
      def human_name = @record[:human_name]
      def cast_name = @record[:cv]
      def birthday = @record[:birthday]
      def cast_birthday = @record[:cv_birthday]
      def title = @record[:title]

      def girl_name = key

      def birthday?
        return !birthday.nil? && birthday != ''
      end

      def cast_birthday?
        return !cast_birthday.nil? && cast_birthday != ''
      end

      def to_h
        return {
          girl_name: girl_name,
          precure_name: precure_name,
          human_name: human_name,
          cast_name: cast_name,
          birthday: birthday,
          cast_birthday: cast_birthday,
          title: title,
        }
      end

      def merge(other)
        return to_h.merge(other)
      end

      def [](key)
        return to_h[key]
      end
    end
  end
end
