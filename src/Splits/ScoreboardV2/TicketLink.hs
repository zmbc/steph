{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.TicketLink (
          TicketLink
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data TicketLink = TicketLink {
  gameID :: String,
  leagTix :: String
} deriving (Show, Eq)

instance Aeson.FromJSON TicketLink where
  parseJSON (Aeson.Object o) = do
      gameID <- o .: "GAME_ID"
      leagTix <- o .: "LEAG_TIX"
      return TicketLink {..}
  parseJSON invalid = Aeson.typeMismatch "TicketLink" invalid
