{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Splits.ScoreboardV2.Available (
          Available
        ) where

import qualified Data.Aeson as Aeson
import qualified Data.Aeson.Types as Aeson
import Data.Aeson ((.:))

data Available = Available {
  gameID :: String,
  ptAvailable :: Integer
} deriving (Show, Eq)

instance Aeson.FromJSON Available where
  parseJSON (Aeson.Object o) = do
      gameID <- o .: "GAME_ID"
      ptAvailable <- o .: "PT_AVAILABLE"
      return Available {..}
  parseJSON invalid = Aeson.typeMismatch "Available" invalid
