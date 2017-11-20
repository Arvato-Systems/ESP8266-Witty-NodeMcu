local module = {}

-- configure an open Accesspoint to connect to your wifi.
-- then continues with get_time()
function start_endusersetup()
    rgb(100, 100, 100)
    wifi.sta.disconnect()
    -- clears the currently saved WiFi station configuration, erasing it from the flash
    wifi.sta.clearconfig()
    wifi.setmode(wifi.STATIONAP)
    --ESP SSID generated with its chipid
    wifi.ap.config({ssid = config.AccessPointSSID .. "-" .. node.chipid(), auth = wifi.OPEN})

    enduser_setup.start(
        function()
            print("Connected to wifi")
            rgb(0, 100, 0)
            app.start()
        end,
        function(err, str)
            rgb(1023, 0, 0)
            print("enduser_setup: Err #" .. err .. ": " .. str)
        end
    )
end

wifi_status_codes = {
    [0] = "Idle",
    [1] = "Connecting",
    [2] = "Wrong Password",
    [3] = "No AP Found",
    [4] = "Connection Failed",
    [5] = "Got IP"
}

-- wait for an IP (10 sec max)
function waitForIp()
    rgb(100, 0, 0)
    tmr.alarm(1, 1000, 1,
        function()
            if wifi.sta.getip() == nil then
                print("Waiting for IP address! (Status: " .. wifi_status_codes[wifi.sta.status()] .. ")")
            else
                print("New IP address is " .. wifi.sta.getip())
                tmr.stop(1)
                rgb(0, 100, 0)
                app.start()
            end
        end
    )
end

-- Use a LED with a 500Hz PWM
local function led(pin, level)
    pwm.setup(pin, 500, level)
    pwm.start(pin)
end

-- Control an RGB LED: three 0->1023 values; higher means more light
function rgb(r, g, b)
    led(config.witty.red, r)
    led(config.witty.green, g)
    led(config.witty.blue, b)
end

function module.start()
    print("Starting up...")
    rgb(0, 0, 500)

    -- configure pins
    print("Configuring GPIO")
    gpio.mode(config.witty.button, gpio.INT, gpio.PULLUP)
    -- start enduser_setup, if the button is pressed
    gpio.trig(config.witty.button, "down",
        function()
            print("Starting Enduser Setup Portal")
            start_endusersetup()
        end
    )
    print("Configuring analog Pin")
    adc.force_init_mode(adc.INIT_ADC)

    -- configure wifi
    print("Configuring Wifi")
    ssid, password, bssid_set, bssid=wifi.sta.getconfig()
    print("Connecting to "..ssid)
    -- clear variables after usage for security
    ssid, password, bssid_set, bssid=nil, nil, nil, nil
    wifi.sta.autoconnect(1)
    -- wait for an IP
    print("Waiting for wifi...")
    waitForIp()
end

return module
