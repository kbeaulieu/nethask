module Nethask.Core.World where

import Nethask.Core.Dungeon (Dungeon)

newtype World = World {
    levels :: [Dungeon]
}

newtype WorldConfig = WorldConfig {
    seed :: Int
}
