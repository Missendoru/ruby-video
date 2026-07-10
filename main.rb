require 'open3'
require 'io/console'

class Fuckingshit
  G = " .'`^\",:;Il!i><~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$░▒▓█".freeze

  def initialize(p)
    @p = p
    h, w = IO.console.winsize
    @w = [[((w * 1.8) * 0.48).to_i, w - 2].min, 1].max
    @h = [[(h * 1.8).to_i, h - 2].min, 1].max
  end
  def play
    sleep 0.8
    print "\e[2J"
    a_pid = spawn("ffmpeg -loglevel quiet -i \"#{@p}\" -f wav - | ffplay -nodisp -autoexit -", out: File::NULL, err: File::NULL)
    cmd = "ffmpeg -loglevel quiet -i \"#{@p}\" -vf \"format=gray,eq=contrast=1.5,scale=#{@w}:#{@h}\" -vcodec rawvideo -pix_fmt gray -f rawvideo -r 24 -"
    Open3.popen3(cmd) do |_, stdout, _, _|
      sz = @w * @h
      fd = 1.0 / 24.0
      t0 = Time.now.to_f
      fc = 0
      until stdout.eof?
        buf = stdout.read(sz)
        break if buf.nil? || buf.bytesize < sz

        fc += 1
        t_target = t0 + (fc * fd)
        next if Time.now.to_f > t_target + fd
        print "\e[H"
        puts _x(buf)

        slp = t_target - Time.now.to_f
        sleep(slp) if slp > 0
      end
    end
  ensure
    if a_pid
      begin; Process.kill("KILL", a_pid); rescue; system("taskkill /F /PID #{a_pid} >nul 2>&1"); end
    end
    print "\e[2J" 
  end
  private
  def _x(b)
    m = b.unpack('C*')
    o = ""
    gl = G.length - 1
    (0...@h).each do |y|
      yo = y * @w
      (0...@w).each { |x| o << G[((m[yo + x] || 0) / 255.0 * gl + 0.5).to_i] }
      o << "\n"
    end
    o
  end
end
if ARGV.empty?
  print "Video?: "
  s = gets.chomp.gsub("\"","")
  if File.exist?(s)
    Fuckingshit.new(s).play
  else
    puts "Doesn't exist... exiting"
    gets
	exit
  end
else
  Fuckingshit.new(ARGV[0]).play
end