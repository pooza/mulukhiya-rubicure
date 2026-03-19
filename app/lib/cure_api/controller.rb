module CureAPI
  class Controller < Sinatra::Base
    before do
      @renderer = Ginseng::Web::JSONRenderer.new
    end

    after do
      content_type(@renderer.type) unless @raw_response
      status @renderer.status
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

    get '/livecure' do
      @renderer.message = LivecureCalendar.new.events
      return @renderer.to_s
    end

    get '/livecure/calendar' do
      tool = Tool.create('livecure')
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
