class WelcomeController < ApplicationController
  require 'em-websocket'
  
  @clients = []

  EM::WebSocket.start(:host => '0.0.0.0', :port => '3005') do |ws|
    ws.onopen do |handshake|
      @clients << ws
      ws.send "Connected"
    end

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |msg|
      puts "Received Message: #{msg}"
      @clients.each do |socket|
        socket.send msg
      end
    end
  end

  def index
    
  end

end
