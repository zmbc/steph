{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.GameHeader (
          GameHeader
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data GameHeader = GameHeader {
  gameDateEST :: String,
  gameSequence :: Integer,
  gameID :: String,
  gameStatusID :: Integer,
  gameStatusText :: String,
  gamecode :: String,
  homeTeamID :: Integer,
  visitorTeamID :: Integer,
  season :: String,
  livePeriod :: Integer,
  livePcTime :: String,
  natlTvBroadcasterAbbreviation :: Maybe String,
  homeTvBroadcasterAbbreviation :: Maybe String,
  awayTvBroadcasterAbbreviation :: Maybe String,
  livePeriodTimeBcast :: String,
  whStatus :: Integer
} deriving (Show, Eq)

instance Aeson.FromJSON GameHeader where
  parseJSON (Aeson.Object o) = do
      gameDateEST <- o .: "GAME_DATE_EST"
      gameSequence <- o .: "GAME_SEQUENCE"
      gameID <- o .: "GAME_ID"
      gameStatusID <- o .: "GAME_STATUS_ID"
      gameStatusText <- o .: "GAME_STATUS_TEXT"
      gamecode <- o .: "GAMECODE"
      homeTeamID <- o .: "HOME_TEAM_ID"
      visitorTeamID <- o .: "VISITOR_TEAM_ID"
      season <- o .: "SEASON"
      livePeriod <- o .: "LIVE_PERIOD"
      livePcTime <- o .: "LIVE_PC_TIME"
      natlTvBroadcasterAbbreviation <- o .: "NATL_TV_BROADCASTER_ABBREVIATION"
      homeTvBroadcasterAbbreviation <- o .: "HOME_TV_BROADCASTER_ABBREVIATION"
      awayTvBroadcasterAbbreviation <- o .: "AWAY_TV_BROADCASTER_ABBREVIATION"
      livePeriodTimeBcast <- o .: "LIVE_PERIOD_TIME_BCAST"
      whStatus <- o .: "WH_STATUS"
      return GameHeader {..}
  parseJSON invalid = Aeson.typeMismatch "GameHeader" invalid
