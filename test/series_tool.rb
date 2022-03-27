module Mulukhiya
  module Rubicure
    class SeriesToolTest < TestCase
      def setup
        @tool = Tool.create('series')
      end

      def test_all
        @tool.exec.first(5).each do |series|
          assert_kind_of(Hash, series)
          assert_kind_of(String, series[:title])
          assert_kind_of(Array, series[:girls])
        end
        assert_equal('application/json; charset=UTF-8', @tool.type)
      end

      def test_one
        assert_kind_of(Hash, @tool.exec(['series', 'dokidoki']))
        assert_raise ::Rubicure::UnknownSeriesError do
          @tool.exec(['girls', 'hogefuga']) # typo
        end

        series = @tool.exec(['series', 'dokidoki'])
        assert_kind_of(Hash, series)
        assert_equal('ドキドキ！プリキュア', series[:title])
        assert_equal(['cure_heart', 'cure_diamond', 'cure_rosetta', 'cure_sword', 'cure_ace'], series[:girls])
        assert_equal('application/json; charset=UTF-8', @tool.type)
      end
    end
  end
end
