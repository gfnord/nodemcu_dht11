print("Booting up ESP8266...")
-- Led settings
local led=4
gpio.mode(led,gpio.OUTPUT)

-- Wifi Configuration
wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid="ESP12-E123", auth=wifi.OPEN})
enduser_setup.manual(true)
enduser_setup.start(
  function()
    print("Connected to wifi as:" .. wifi.sta.getip())
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end
);

-- Reads DHT11 data every 20 seconds and send to endpoint
dofile("dht11.lua")
tmr.alarm(1,20000,1,function()
  if wifi.sta.getip() == nil then
    print('No connection, waiting...')
  else
    gpio.write(led, gpio.LOW)
    sendData_dht11()
    gpio.write(led, gpio.HIGH)
  end
end)