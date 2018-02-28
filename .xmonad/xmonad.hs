import XMonad
import System.IO

main = do
  xmonad defaultConfig
    { modMask = mod4Mask }

