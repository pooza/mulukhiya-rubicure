module CureAPI
  class Controller < Sinatra::Base
    ENDPOINTS = [
      {path: '/girls', description: 'すべてのプリキュア (JSON)'},
      {path: '/girls/index', description: 'プリキュア名の一覧 (JSON)'},
      {path: '/girls/:name', description: '指定したプリキュア (JSON)', example: '/girls/cure_black'},
      {path: '/girls/calendar', description: 'プリキュアの誕生日カレンダー (iCalendar)'},
      {path: '/series', description: 'すべてのシリーズ (JSON)'},
      {path: '/series/index', description: 'シリーズ名の一覧 (JSON)'},
      {path: '/series/:name', description: '指定したシリーズ (JSON)', example: '/series/dokidoki'},
      {path: '/cast/calendar', description: 'キャストの誕生日カレンダー (iCalendar)'},
    ].freeze

    before do
      @renderer = Ginseng::Web::JSONRenderer.new
    end

    after do
      content_type(@renderer.type) unless @raw_response
      status @renderer.status
    end

    get '/' do
      @raw_response = true
      content_type 'text/html; charset=UTF-8'
      items = ENDPOINTS.map do |ep|
        href = ep[:example] || ep[:path]
        "<li><a href=\"#{href}\">#{ep[:path]}</a> &mdash; #{ep[:description]}</li>"
      end.join("\n        ")
      return <<~HTML
        <!DOCTYPE html>
        <html lang="ja">
        <head><meta charset="UTF-8"><title>#{Package.name}</title></head>
        <body>
        <h1>#{Package.name}</h1>
        <p>#{Package.full_name}</p>
        <h2>エンドポイント一覧</h2>
        <ul>
        #{items}
        </ul>
        </body>
        </html>
      HTML
    end

    get '/girls' do
      tool = Tool.create('girls')
      @renderer.message = tool.all
      return @renderer.to_s
    end

    get '/girls/index' do
      tool = Tool.create('girls')
      @renderer.message = tool.index
      return @renderer.to_s
    end

    get '/girls/calendar' do
      tool = Tool.create('girls')
      @raw_response = true
      content_type 'text/calendar; charset=UTF-8'
      return tool.ical
    end

    get '/girls/:name' do
      tool = Tool.create('girls')
      @renderer.message = tool.girl(params[:name])
      return @renderer.to_s
    rescue Ginseng::NotFoundError => e
      @renderer.status = 404
      @renderer.message = {error: e.message}
      return @renderer.to_s
    end

    get '/series' do
      tool = Tool.create('series')
      @renderer.message = tool.all
      return @renderer.to_s
    end

    get '/series/index' do
      tool = Tool.create('series')
      @renderer.message = tool.index
      return @renderer.to_s
    end

    get '/series/:name' do
      tool = Tool.create('series')
      @renderer.message = tool.series(params[:name])
      return @renderer.to_s
    rescue Ginseng::NotFoundError => e
      @renderer.status = 404
      @renderer.message = {error: e.message}
      return @renderer.to_s
    end

    get '/cast/calendar' do
      tool = Tool.create('cast')
      @raw_response = true
      content_type 'text/calendar; charset=UTF-8'
      return tool.ical
    end

    get '/help' do
      tool = Tool.create('help')
      @raw_response = true
      content_type 'text/plain; charset=UTF-8'
      return tool.exec
    end

    error do
      e = env['sinatra.error']
      @renderer.status = 500
      @renderer.message = {error: e.message}
      return @renderer.to_s
    end
  end
end
