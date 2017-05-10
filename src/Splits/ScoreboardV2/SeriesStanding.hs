{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.SeriesStanding (
          SeriesStanding
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data SeriesStanding = SeriesStanding {
  gameID :: String,
  homeTeamID :: Integer,
  visitorTeamID :: Integer,
  gameDateEST :: String,
  homeTeamWins :: Integer,
  homeTeamLosses :: Integer,
  seriesLeader :: String
} deriving (Show, Eq)

instance Aeson.FromJSON SeriesStanding where
  parseJSON (Aeson.Object o) = do
      gameID <- o .: "GAME_ID"
      homeTeamID <- o .: "HOME_TEAM_ID"
      visitorTeamID <- o .: "VISITOR_TEAM_ID"
      gameDateEST <- o .: "GAME_DATE_EST"
      homeTeamWins <- o .: "HOME_TEAM_WINS"
      homeTeamLosses <- o .: "HOME_TEAM_LOSSES"
      seriesLeader <- o .: "SERIES_LEADER"
      return SeriesStanding {..}
  parseJSON invalid = Aeson.typeMismatch "SeriesStanding" invalid
