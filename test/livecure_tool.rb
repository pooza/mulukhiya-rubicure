module Mulukhiya
  module Rubicure
    class LivecureTest < TestCase
      def setup
        @tool = Tool.create('livecure')
      end

      def test_exec
        result = @tool.exec(['livecure'])

        assert_kind_of(Hash, result)
        result.first(5).each do |date, girls|
          assert_kind_of(Date, date)
          assert_kind_of(Array, girls)
          girls.each do |girl|
            assert_kind_of(Hash, girl)
            assert_kind_of(String, girl[:girl_name])
            assert_kind_of(String, girl[:human_name])
            assert_kind_of(String, girl[:precure_name])
          end
        end
      end

      def test_calendar
        result = @tool.exec(['livecure', 'calendar'])

        assert_equal("BEGIN:VCALENDAR\r\n", result.lines.first)
        assert_equal('text/calendar; charset=UTF-8', @tool.type)
      end
    end
  end
end
