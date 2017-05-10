{-# LANGUAGE OverloadedStrings #-}

module Data.NBA.Endpoints.ScoreboardV2
    ( scoreboard,
      Scoreboard,
      gameHeaders,
      lineScores,
      seriesStandings,
      lastMeetings,
      eastConfStandingsByDay,
      westConfStandingsByDay,
      availables,
      teamLeadersList,
      ticketLinks
    ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))
import qualified Data.NBA.Stats as Kawhi
import Data.Time
import qualified Data.Text as Text
import qualified Network.HTTP.Simple as HTTPSimple
import qualified Network.HTTP.Client as HTTP
import qualified Data.ByteString.Lazy as LBS
import qualified Data.ByteString.Char8 as Char8
import Data.Monoid ((<>))

import Splits.ScoreboardV2.LineScore
import Splits.ScoreboardV2.GameHeader
import Splits.ScoreboardV2.SeriesStanding
import Splits.ScoreboardV2.LastMeeting
import Splits.ScoreboardV2.Standing
import Splits.ScoreboardV2.Available
import Splits.ScoreboardV2.TeamLeaders
import Splits.ScoreboardV2.TicketLink

parseGameHeaders :: LBS.ByteString -> Either Kawhi.StatsError [GameHeader]
parseGameHeaders = Kawhi.splitRows "GameHeader"

parseLineScores :: LBS.ByteString -> Either Kawhi.StatsError [LineScore]
parseLineScores = Kawhi.splitRows "LineScore"

parseSeriesStandings :: LBS.ByteString -> Either Kawhi.StatsError [SeriesStanding]
parseSeriesStandings = Kawhi.splitRows "SeriesStandings"

parseLastMeetings :: LBS.ByteString -> Either Kawhi.StatsError [LastMeeting]
parseLastMeetings = Kawhi.splitRows "LastMeeting"

parseEastConfStandingsByDay :: LBS.ByteString -> Either Kawhi.StatsError [Standing]
parseEastConfStandingsByDay = Kawhi.splitRows "EastConfStandingsByDay"

parseWestConfStandingsByDay :: LBS.ByteString -> Either Kawhi.StatsError [Standing]
parseWestConfStandingsByDay = Kawhi.splitRows "WestConfStandingsByDay"

parseAvailables :: LBS.ByteString -> Either Kawhi.StatsError [Available]
parseAvailables = Kawhi.splitRows "Available"

parseTeamLeadersList :: LBS.ByteString -> Either Kawhi.StatsError [TeamLeaders]
parseTeamLeadersList = Kawhi.splitRows "TeamLeaders"

parseTicketLinks :: LBS.ByteString -> Either Kawhi.StatsError [TicketLink]
parseTicketLinks = Kawhi.splitRows "TicketLinks"

data Scoreboard = Scoreboard {
  gameHeaders :: Either Kawhi.StatsError [GameHeader],
  lineScores :: Either Kawhi.StatsError [LineScore],
  seriesStandings :: Either Kawhi.StatsError [SeriesStanding],
  lastMeetings :: Either Kawhi.StatsError [LastMeeting],
  eastConfStandingsByDay :: Either Kawhi.StatsError [Standing],
  westConfStandingsByDay :: Either Kawhi.StatsError [Standing],
  availables :: Either Kawhi.StatsError [Available],
  teamLeadersList :: Either Kawhi.StatsError [TeamLeaders],
  ticketLinks :: Either Kawhi.StatsError [TicketLink]
  --winProbabilities :: Either Kawhi.StatsError [WinProbability] As of now, these don't really seem to exist
} deriving (Show, Eq)

scoreboard :: Day -> IO Scoreboard
scoreboard day = Scoreboard
                  <$> (parseGameHeaders <$> resp)
                  <*> (parseLineScores <$> resp)
                  <*> (parseSeriesStandings <$> resp)
                  <*> (parseLastMeetings <$> resp)
                  <*> (parseEastConfStandingsByDay <$> resp)
                  <*> (parseWestConfStandingsByDay <$> resp)
                  <*> (parseAvailables <$> resp)
                  <*> (parseTeamLeadersList <$> resp)
                  <*> (parseTicketLinks <$> resp)
  where
    resp = HTTP.responseBody <$> get day

-- Referer=stats.nba.com is necessary for this endpoint
get :: Day -> IO (HTTP.Response LBS.ByteString)
get day =
    modifyRequest <$> HTTP.parseRequest (Text.unpack "http://stats.nba.com/stats/scoreboardv2")
    >>= HTTPSimple.httpLbs
    where
      modifyRequest =
        HTTPSimple.setRequestHeaders [("Accept-Language","en-us"), ("Accept", "application/json"), ("Referer", "stats.nba.com")]
        . HTTP.setQueryString [
          ("DayOffset", Just "0"),
          ("LeagueID", Just "00"),
          ("gameDate", Just (Char8.pack (formatTime defaultTimeLocale "%m/%d/%Y" day)))
        ]
