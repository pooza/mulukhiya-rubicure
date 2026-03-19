module CureAPI
  class SeriesToolTest < TestCase
    def setup
      @tool = Tool.create('series')
    end

    def test_all
      @tool.exec.first(5).each do |series|
        assert_kind_of(Hash, series)
        assert_kind_of(String, series[:title])
      end
      assert_equal('application/json; charset=UTF-8', @tool.type)
    end

    def test_one
      assert_kind_of(Hash, @tool.exec(['series', 'dokidoki']))
      assert_raise Ginseng::NotFoundError do
        @tool.exec(['series', 'hogefuga']) # typo
      end

      series = @tool.exec(['series', 'dokidoki'])

      assert_kind_of(Hash, series)
      assert_equal('ドキドキ！プリキュア', series[:title])
      assert_equal('application/json; charset=UTF-8', @tool.type)
    end
  end
end
