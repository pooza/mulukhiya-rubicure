module Mulukhiya
  module Rubicure
    class Calendar
      attr_accessor :days, :years, :all

      def initialize(params = {})
        @days = params[:days] || 60
        @years = params[:years] || 1
        @all = params.key?(:all) ? params[:all] : true
      end

      def today
        return Date.today
      end

      alias all? all

      def include?(date)
        return true if all?
        return false if date < today
        return false if today + days < date
        return true
      end

      def dates
        raise Ginseng::ImplementError, "'#{__method__}' not implemented"
      end
    end
  end
end
