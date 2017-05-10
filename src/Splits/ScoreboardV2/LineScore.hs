{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.LineScore (
          LineScore
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data LineScore = LineScore {
  gameDateEST :: String,
  gameSequence :: Integer,
  gameID :: String,
  teamID :: Integer,
  teamAbbreviation :: String,
  teamCityName :: String,
  teamWinsLosses :: String,
  ptsQtr1 :: Maybe Integer,
  ptsQtr2 :: Maybe Integer,
  ptsQtr3 :: Maybe Integer,
  ptsQtr4 :: Maybe Integer,
  ptsOT1 :: Maybe Integer,
  ptsOT2 :: Maybe Integer,
  ptsOT3 :: Maybe Integer,
  ptsOT4 :: Maybe Integer,
  ptsOT5 :: Maybe Integer,
  ptsOT6 :: Maybe Integer,
  ptsOT7 :: Maybe Integer,
  ptsOT8 :: Maybe Integer,
  ptsOT9 :: Maybe Integer,
  ptsOT10 :: Maybe Integer,
  pts :: Maybe Integer,
  fgPct :: Maybe Float,
  ftPct :: Maybe Float,
  fg3Pct :: Maybe Float,
  ast :: Maybe Integer,
  reb :: Maybe Integer,
  tov :: Maybe Integer
} deriving (Show, Eq)

instance Aeson.FromJSON LineScore where
  parseJSON (Aeson.Object o) = do
      gameDateEST <- o .: "GAME_DATE_EST"
      gameSequence <- o .: "GAME_SEQUENCE"
      gameID <- o .: "GAME_ID"
      teamID <- o .: "TEAM_ID"
      teamAbbreviation <- o .: "TEAM_ABBREVIATION"
      teamCityName <- o .: "TEAM_CITY_NAME"
      teamWinsLosses <- o .: "TEAM_WINS_LOSSES"
      ptsQtr1 <- o .: "PTS_QTR1"
      ptsQtr2 <- o .: "PTS_QTR2"
      ptsQtr3 <- o .: "PTS_QTR3"
      ptsQtr4 <- o .: "PTS_QTR4"
      ptsOT1 <- o .: "PTS_OT1"
      ptsOT2 <- o .: "PTS_OT2"
      ptsOT3 <- o .: "PTS_OT3"
      ptsOT4 <- o .: "PTS_OT4"
      ptsOT5 <- o .: "PTS_OT5"
      ptsOT6 <- o .: "PTS_OT6"
      ptsOT7 <- o .: "PTS_OT7"
      ptsOT8 <- o .: "PTS_OT8"
      ptsOT9 <- o .: "PTS_OT9"
      ptsOT10 <- o .: "PTS_OT10"
      pts <- o .: "PTS"
      fgPct <- o .: "FG_PCT"
      ftPct <- o .: "FT_PCT"
      fg3Pct <- o .: "FG3_PCT"
      ast <- o .: "AST"
      reb <- o .: "REB"
      tov <- o .: "TOV"
      return LineScore {..}
  parseJSON invalid = Aeson.typeMismatch "LineScore" invalid
