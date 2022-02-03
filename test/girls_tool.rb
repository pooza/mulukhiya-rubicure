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
        assert_equal(@tool.type, 'application/json; charset=UTF-8')
      end

      def test_one
        assert_kind_of(Hash, @tool.exec(['girls', 'cure_sword']))
        assert_raise RuntimeError do
          @tool.exec(['girls', 'swords']) # typo
        end

        girl = @tool.exec(['girls', 'sword'])
        assert_kind_of(Hash, girl)
        assert_equal(girl[:girl_name], 'cure_sword')
        assert_equal(girl[:human_name], '剣崎 真琴')
        assert_equal(girl[:precure_name], 'キュアソード')
        assert_equal(@tool.type, 'application/json; charset=UTF-8')

        girl = @tool.exec(['girls', 'moonlight'])
        assert_kind_of(Hash, girl)
        assert_equal(girl[:transform_message], "プリキュア！オープンマイハート！\n月光に冴える一輪の花 キュアムーンライト！\nハートキャッチ、プリキュア！")

        girl = @tool.exec(['girls', 'yell'])
        assert_kind_of(Hash, girl)
        assert_equal(girl[:cast_birthday], '9/11')
      end

      def test_calendar
        result = @tool.exec(['girls', 'calendar'])
        assert_equal(result.lines.first, "BEGIN:VCALENDAR\r\n")
        assert_equal(@tool.type, 'text/calendar; charset=UTF-8')
      end
    end
  end
end
