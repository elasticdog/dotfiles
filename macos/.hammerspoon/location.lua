local wifiWatcher = nil
local homeSSID = "deadlight"
local lastSSID = hs.wifi.currentNetwork()

-- mute the speaker volume when not at home
function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- we just joined our home wifi network
        hs.audiodevice.defaultOutputDevice():setMuted(false)
        hs.notify.new({
            title='Hammerspoon',
            informativeText='Arrived home; speaker volume un-muted'
        }):send()
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- we just joined a wifi network outside of our home
        hs.audiodevice.defaultOutputDevice():setMuted(true)
        hs.notify.new({
            title='Hammerspoon',
            informativeText='Left home; speaker volume muted'
        }):send()
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
