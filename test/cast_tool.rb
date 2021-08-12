module Mulukhiya
  module Rubicure
    class CastToolTest < TestCase
      def setup
        @tool = Tool.create('cast')
      end

      def test_calendar
        result = @tool.exec(['cast', 'calendar'])
        assert_equal(result.lines.first, "BEGIN:VCALENDAR\r\n")
        assert_equal(@tool.type, 'text/calendar; charset=UTF-8')
      end
    end
  end
end
