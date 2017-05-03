require 'chunky_png'

png = ChunkyPNG::Image.new(32*8, 24*8, ChunkyPNG::Color::TRANSPARENT)

bytes = File.binread(ARGV[0]).unpack("C*")

offset = 0
for j in 0..23 do
  for i in 0..31 do
    from_y = 8*j
    from_x = 8*i
    for y in from_y..(from_y + 7) do
      byte = bytes[offset]
      byte.to_s(2).rjust(8, '0').split("").each_with_index do |bit, k|
        x = from_x + k
        color = case bit
          when "0" then ChunkyPNG::Color.rgba(0x00, 0x00, 0x00, 0xff)
          when "1" then ChunkyPNG::Color.rgba(0xff, 0xff, 0xff, 0xff)
        end
        png[x, y] = color
      end
      offset += 1
    end
  end
end

png.save('tileset.png', interlace: true)
