{-# OPTIONS_GHC -W -fwarn-unused-imports -fno-warn-missing-signatures #-}

module Main where

import Data.Ratio
import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doRectFloat)
import XMonad.Hooks.SetWMName
import XMonad.Layout.Column
import XMonad.Layout.Reflect
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.WindowProperties (propertyToQuery, Property(Role))
import System.Taffybar.Support.PagerHints (pagerHints)

import qualified XMonad.StackSet as W

-- good reference: https://joeyh.name/blog/entry/xmonad_layouts_for_netbooks/

tallLayout = Tall 1 (3/100) (3/5)
myLayout = (Column 1.4) |||
           reflectHoriz tallLayout ||| Full

conf = def
  { modMask = mod4Mask
  , terminal = "urxvt"
  , layoutHook = avoidStruts $ myLayout
  -- https://crbug.com/471061
  , manageHook = manageDocks <+>  (propertyToQuery (Role "GtkFileChooserDialog") --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2))) <+> scratchpadManageHook (W.RationalRect 0.2 0.2 0.6 0.6) -- l t w h
  -- consider https://chipsenkbeil.com/notes/fix-for-xmonad-with-xmobar/ if the
  -- problem with windows obscuring taffybar reoccurs
  , startupHook = setWMName "LG3D"
  }

myKeys =
    [ (("M-S-l"), safeSpawnProg "/usr/share/goobuntu-desktop-files/xsecurelock.sh")

    -- media keys
    , (("<XF86AudioLowerVolume>"), safeSpawn "cmus-remote" ["-v", "-10%"])
    , (("<XF86AudioRaiseVolume>"), safeSpawn "cmus-remote" ["-v", "+10%"])
    , (("<XF86AudioPlay>"), safeSpawn "cmus-remote" ["-u"])
    , (("<XF86AudioPrev>"), safeSpawn "cmus-remote" ["-r"])
    , (("<XF86AudioNext>"), safeSpawn "cmus-remote" ["-n"])

    -- LH-friendly workspace switching:
    , (("M-a"), windows $ W.greedyView "1")
    , (("M-s"), windows $ W.greedyView "2")
    , (("M-d"), windows $ W.greedyView "3")
    , (("M-f"), windows $ W.greedyView "4")
    , (("M-g"), windows $ W.greedyView "5")
    , (("M-S-a"), windows $ W.shift "1")
    , (("M-S-s"), windows $ W.shift "2")
    , (("M-S-d"), windows $ W.shift "3")
    , (("M-S-f"), windows $ W.shift "4")
    , (("M-S-g"), windows $ W.shift "5")

    -- alternate nextLayout binding since M-spc doesn't work with MT(LGUI, SPC):
    , (("M-z"), sendMessage NextLayout)

    -- global hotkeys
    , (("M1-S-C-M4-f"), scratchpadSpawnAction conf)
    , (("M1-S-C-M4-c"), safeSpawnProg "capture.sh") ]

main = xmonad $
  docks $
  ewmh $
  pagerHints
  conf `additionalKeysP` myKeys `additionalMouseBindings` [((0, 8), (\w -> focus w >> windows W.swapMaster))]

-- TODO: use dunst for notifications?
-- https://github.com/dunst-project/dunst/blob/master/dunstrc#L269
