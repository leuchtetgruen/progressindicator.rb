$: << "."

require "web_socket"
require 'pty'

def run_server(port, command)
  server = WebSocketServer.new(:port => port, :accepted_domains => ["*"])
  server.run() do |ws|

    # The block is called for each connection.
    # Checks requested path.
    if ws.path == "/"
      # Call ws.handshake() without argument first.
      ws.handshake()


      PTY.spawn command do |r,w,p|
        loop do
          line = r.gets.strip
          p line          
          ws.send(line)          
        end
      end


      ws.close()
    else
      # You can call ws.handshake() with argument to return error status.
      ws.handshake("404 Not Found")
    end
  end
end

# --- main program ---


if ARGV.size != 2
  $stderr.puts("Usage: ruby cli_ws_bridge.rb port command")
  exit(1)
end

puts "Running server on ws://localhost:#{ARGV[0]}/"
run_server(ARGV[0], ARGV[1])