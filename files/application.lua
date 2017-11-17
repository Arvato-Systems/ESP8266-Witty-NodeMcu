local module = {}

function module.start()
  print('application start')

  -- read LDR every second
  tmr.alarm(0, 1000, 1, function()
    sensorValue = adc.read(0)
    print("Sensor value: "..sensorValue)
  end)
end

return module
