--- Sensor DHT11 is conntected to GPIO4
local dht_pin = 2

local humi = 0
local humi_dec=0
local temp = 0
local temp_dec=0

function getTemp()
    status, temp, humi, temp_dec, humi_dec = dht.read11(dht_pin)
    if status == dht.OK then
        -- Float firmware using this example
        print("DHT Temperature:"..temp..";".."Humidity:"..humi)

    elseif status == dht.ERROR_CHECKSUM then
        print( "DHT Checksum error." )
    elseif status == dht.ERROR_TIMEOUT then
        print( "DHT timed out." )
    end
end