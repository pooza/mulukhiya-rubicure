module Mulukhiya
  module Rubicure
    class GirlsToolTest < TestCase
      def setup
        @tool = Tool.create('girls')
      end

      def test_all
        @tool.exec.first(5).each do |girl|
          assert_kind_of(Hash, girl)
          assert_kind_of(String, girl[:girl_name])
          assert_kind_of(String, girl[:human_name])
          assert_kind_of(String, girl[:precure_name])
        end
        assert_equal('application/json; charset=UTF-8', @tool.type)
      end

      def test_one
        assert_kind_of(Hash, @tool.exec(['girls', 'cure_sword']))
        assert_raise RuntimeError do
          @tool.exec(['girls', 'swords']) # typo
        end

        girl = @tool.exec(['girls', 'sword'])

        assert_kind_of(Hash, girl)
        assert_equal('cure_sword', girl[:girl_name])
        assert_equal('剣崎 真琴', girl[:human_name])
        assert_equal('キュアソード', girl[:precure_name])
        assert_equal('application/json; charset=UTF-8', @tool.type)

        girl = @tool.exec(['girls', 'moonlight'])

        assert_kind_of(Hash, girl)
        assert_equal("プリキュア！オープンマイハート！\n月光に冴える一輪の花 キュアムーンライト！\nハートキャッチ、プリキュア！", girl[:transform_message])

        girl = @tool.exec(['girls', 'yell'])

        assert_kind_of(Hash, girl)
        assert_equal('9/11', girl[:cast_birthday])
      end

      def test_calendar
        result = @tool.exec(['girls', 'calendar'])

        assert_equal("BEGIN:VCALENDAR\r\n", result.lines.first)
        assert_equal('text/calendar; charset=UTF-8', @tool.type)
      end
    end
  end
end
