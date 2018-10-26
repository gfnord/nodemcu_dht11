--- Sensor DHT11 is conntected to GPIO4
local dht_pin = 2

local humi = 0
local humi_dec=0
local temp = 0
local temp_dec=0
local API_endpoint = "18.191.55.98:8080"

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

--- Get temp and send data to API
function sendData_dht11()
    getTemp() -- Capture the data from DHT11
    if status == dht.OK then
        -- send Temperature
        http.get("http://"..API_endpoint.."/write?id="..node.chipid().."&type=10&value="..temp, nil, function(code, data)
            if (code < 0) then
                print("HTTP Temperature request failed")
            end
        end)
        -- send Humidity
        http.get("http://"..API_endpoint.."/write?id="..node.chipid().."&type=20&value="..humi, nil, function(code, data)
            if (code < 0) then
                print("HTTP Humidity request failed")
            end
        end)
    end
end
