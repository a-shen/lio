{-# LANGUAGE Trustworthy #-}

{- |

This module re-exports "Data.Time" wrapped in 'LIO'.

WARNING: The time functions can be used to carry out
/external-timing attacks/ with less effort than using threads and
synchronization. It is therefore advised that computations that
operate on sensitive data take the same amount of time regardless of
the input.

-}
module LIO.Data.Time (
    module Data.Time
  , getCurrentTime
  , getZonedTime
  , utcToLocalZonedTime ) where

import qualified Data.Time as T
import Data.Time hiding ( getCurrentTime
                        , getZonedTime
                        , utcToLocalZonedTime)
import LIO
import LIO.TCB

-- | Get the current UTC time from the system clock.
getCurrentTime :: Label l => LIO l UTCTime
getCurrentTime = rethrowIoTCB T.getCurrentTime

-- | Get the local time together with a TimeZone.
getZonedTime :: Label l => LIO l ZonedTime
getZonedTime = rethrowIoTCB T.getZonedTime

-- | Convert UTC time to local time with TimeZone.
utcToLocalZonedTime :: Label l => UTCTime -> LIO l ZonedTime
utcToLocalZonedTime = rethrowIoTCB . T.utcToLocalZonedTime
