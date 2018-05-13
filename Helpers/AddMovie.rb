# require 'management'
require 'base64'
require 'rmagick'

puts 'Start adding'
puts 'tmp images deleting....'
`rm tmp/images/*.jpg`
puts 'tmp images deleted'
puts 'Images creating...'
`ffmpeg -i test2.mp4 tmp/images/%d.png`
puts 'Image created'

data = []
# Dir['tmp/images/*.jpg'].sort_by(&:to_i).each_with_index do |image|
Dir['tmp/images/*.png'].sort_by(&:to_i).each_with_index do |image|
  `convert #{image} -resize 30x30 #{image}`
  data << Base64.encode64(File.open("resize_#{image}").read)

end
p data