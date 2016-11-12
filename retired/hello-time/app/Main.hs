module Main where

import HelloTime (foo)
import Data.Maybe


-- http://hackage.haskell.org/package/time-1.6
import Data.Time.Clock
import Data.Time.Format
import Data.Time.LocalTime
import Data.Time.Calendar

import Data.Time.Zones

main = do
    --
    t <- getCurrentTime 
    print $ formatTime defaultTimeLocale "%F %T" t 
    --
    zt <- getZonedTime
    print $ formatTime defaultTimeLocale "%F %T" zt 
    -- convert the zoned time to utc
    print $ formatTime defaultTimeLocale "%F %T" (zonedTimeToUTC zt)
    --
    -- use ZonedTimeZone to get the TimeZone from zt
    -- then use timeZoneOffsetString to get the text
    -- representation of that offset
    print $ timeZoneOffsetString (zonedTimeZone zt)
    --
    tz <- getCurrentTimeZone
    print tz
    -- construct a timezone from hour offset
    let pst = hoursToTimeZone (-8)
    print pst
    -- construct a timezone from minute offset
    let est = minutesToTimeZone (60 * (-5)) 
    print est
    --
    -- convert a utc time to a specific timezone
    --
    print $ utcToZonedTime pst t
    --
    -- manually construct a TimeZone
    let x = TimeZone 8 False "FOO"
    print x
    --
    let day = fromGregorianValid 2016 1 1
    print day
    let t99 = UTCTime (fromJust day) 0
    print t99
    let t88 = addUTCTime 33 t99
    print t88
    print $ addUTCTime 33 t99
    print $ diffUTCTime t88 t99
    --
    -- convert timezone string to timezone
    --   use names (olson format) or POSIX format spec
    --   http://www.ibm.com/developerworks/aix/library/au-aix-posix/
    --   https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    --
    print "------------"
    stz <- loadSystemTZ "America/Denver"
    print $ timeZoneForUTCTime stz t
