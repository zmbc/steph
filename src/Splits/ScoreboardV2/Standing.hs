{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.Standing (
          Standing
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data Standing = Standing {
  teamID :: Integer,
  leagueID :: String,
  seasonID :: String,
  standingsDate :: String,
  conference :: String,
  team :: String,
  g :: Integer,
  w :: Integer,
  l :: Integer,
  wPct :: Float,
  homeRecord :: String,
  roadRecord :: String
} deriving (Show, Eq)

instance Aeson.FromJSON Standing where
  parseJSON (Aeson.Object o) = do
      teamID <- o .: "TEAM_ID"
      leagueID <- o .: "LEAGUE_ID"
      seasonID <- o .: "SEASON_ID"
      standingsDate <- o .: "STANDINGSDATE"
      conference <- o .: "CONFERENCE"
      team <- o .: "TEAM"
      g <- o .: "G"
      w <- o .: "W"
      l <- o .: "L"
      wPct <- o .: "W_PCT"
      homeRecord <- o .: "HOME_RECORD"
      roadRecord <- o .: "ROAD_RECORD"
      return Standing {..}
  parseJSON invalid = Aeson.typeMismatch "Standing" invalid
