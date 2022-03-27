module Mulukhiya
  module Rubicure
    class CastToolTest < TestCase
      def setup
        @tool = Tool.create('cast')
      end

      def test_calendar
        result = @tool.exec(['cast', 'calendar'])
        assert_equal("BEGIN:VCALENDAR\r\n", result.lines.first)
        assert_equal('text/calendar; charset=UTF-8', @tool.type)
      end
    end
  end
end
