{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.TeamLeaders (
          TeamLeaders
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data TeamLeaders = TeamLeaders {
  gameID :: String,
  teamID :: Integer,
  teamCity :: String,
  teamNickname :: String,
  teamAbbreviation :: String,
  ptsPlayerID :: Integer,
  ptsPlayerName :: String,
  pts :: Integer,
  rebPlayerID :: Integer,
  rebPlayerName :: String,
  reb :: Integer,
  astPlayerID :: Integer,
  astPlayerName :: String,
  ast :: Integer
} deriving (Show, Eq)

instance Aeson.FromJSON TeamLeaders where
  parseJSON (Aeson.Object o) = do
      gameID <- o .: "GAME_ID"
      teamID <- o .: "TEAM_ID"
      teamCity <- o .: "TEAM_CITY"
      teamNickname <- o .: "TEAM_NICKNAME"
      teamAbbreviation <- o .: "TEAM_ABBREVIATION"
      ptsPlayerID <- o .: "PTS_PLAYER_ID"
      ptsPlayerName <- o .: "PTS_PLAYER_NAME"
      pts <- o .: "PTS"
      rebPlayerID <- o .: "REB_PLAYER_ID"
      rebPlayerName <- o .: "REB_PLAYER_NAME"
      reb <- o .: "REB"
      astPlayerID <- o .: "AST_PLAYER_ID"
      astPlayerName <- o .: "AST_PLAYER_NAME"
      ast <- o .: "AST"
      return TeamLeaders {..}
  parseJSON invalid = Aeson.typeMismatch "TeamLeaders" invalid
