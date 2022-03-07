{-# LANGUAGE OverloadedStrings #-}

import System.Taffybar
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget
import System.Taffybar.Widget.Battery
import System.Taffybar.Widget.Generic.PollingGraph
import System.Taffybar.Information.Memory
import System.Taffybar.Information.CPU
import Control.Monad.IO.Class

memCallback = do
    mi <- parseMeminfo
    return [ memoryUsedRatio mi ]

cpuCallback = do
    ( userLoad, systemLoad, totalLoad ) <- cpuLoad
    return [ totalLoad, systemLoad ]

main = do
    let memCfg = defaultGraphConfig { graphDataColors
            = [ ( 1, 0, 0, 1 ) ], graphLabel = Just "mem" }
        cpuCfg = defaultGraphConfig { graphDataColors
            = [ ( 0, 1, 0, 1 ), ( 1, 0, 1, 0.5 ) ], graphLabel = Just "cpu" }
        clock = textClockNew Nothing "%a %b %_d %H:%M" 1
        battery = textBatteryNew " [$time$, $percentage$%] "
        mem = pollingGraphNew memCfg 1 memCallback
        cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
        tray = sniTrayThatStartsWatcherEvenThoughThisIsABadWayToDoIt
        weather = liftIO $ commandRunnerNew 1200 "curl"
            [ "wttr.in/Arvada?format=4" ] "no weather" -- "#2aa198"
    simpleTaffybar defaultSimpleTaffyConfig { barHeight = 46, startWidgets
        = [ weather ], endWidgets = [ tray, clock, battery, mem, cpu ] }
