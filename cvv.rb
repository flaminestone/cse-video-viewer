require_relative 'management'
require 'base64'

class Api < Sinatra::Base
  attr_accessor :params
  def initialize
    super
  end

  before do
    content_type :json
  end

  post '/get_frame' do
    resolution = params['resolution'] || '30x30'
    `rm tmp/images/*.png`
    `ffmpeg -i assets/test.mp4 tmp/images/%d.png`
    data = []
    Dir['tmp/images/*.png'].sort_by { |dir| File.basename(dir, '.png').to_i }.each_with_index do |image|
      `convert #{image} -resize #{resolution} -rotate "270" #{image}`
      data << ('data:image/png;base64,' + Base64.encode64(File.open(image).read))
    end
    { data: data }.to_json
  end

  get '/' do
    'hello'
  end
end
