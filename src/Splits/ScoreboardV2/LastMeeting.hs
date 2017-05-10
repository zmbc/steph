{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.LastMeeting (
          LastMeeting
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data LastMeeting = LastMeeting {
  gameID :: String,
  lastGameID :: String,
  lastGameDateEST :: String,
  lastGameHomeTeamID :: Integer,
  lastGameHomeTeamCity :: String,
  lastGameHomeTeamName :: String,
  lastGameHomeTeamAbbreviation :: String,
  lastGameHomeTeamPoints :: Integer,
  lastGameVisitorTeamID :: Integer,
  lastGameVisitorTeamCity :: String,
  lastGameVisitorTeamName :: String,
  lastGameVisitorTeamAbbreviation :: String,
  lastGameVisitorTeamPoints :: Integer
} deriving (Show, Eq)

instance Aeson.FromJSON LastMeeting where
  parseJSON (Aeson.Object o) = do
      gameID <- o .: "GAME_ID"
      lastGameID <- o .: "LAST_GAME_ID"
      lastGameDateEST <- o .: "LAST_GAME_DATE_EST"
      lastGameHomeTeamID <- o .: "LAST_GAME_HOME_TEAM_ID"
      lastGameHomeTeamCity <- o .: "LAST_GAME_HOME_TEAM_CITY"
      lastGameHomeTeamName <- o .: "LAST_GAME_HOME_TEAM_NAME"
      lastGameHomeTeamAbbreviation <- o .: "LAST_GAME_HOME_TEAM_ABBREVIATION"
      lastGameHomeTeamPoints <- o .: "LAST_GAME_HOME_TEAM_POINTS"
      lastGameVisitorTeamID <- o .: "LAST_GAME_VISITOR_TEAM_ID"
      lastGameVisitorTeamCity <- o .: "LAST_GAME_VISITOR_TEAM_CITY"
      lastGameVisitorTeamName <- o .: "LAST_GAME_VISITOR_TEAM_NAME"
      lastGameVisitorTeamAbbreviation <- o .: "LAST_GAME_VISITOR_TEAM_ABBREVIATION"
      lastGameVisitorTeamPoints <- o .: "LAST_GAME_VISITOR_TEAM_POINTS"
      return LastMeeting {..}
  parseJSON invalid = Aeson.typeMismatch "LastMeeting" invalid
