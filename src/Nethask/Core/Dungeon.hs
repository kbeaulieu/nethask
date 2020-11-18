module Nethask.Core.Dungeon where

import Nethask.Core.Common (Point, Size)

data Dungeon = Dungeon {
    rooms :: [Room],
    corridors :: [Corridor]
} deriving (Show)

createEmptyDungeon :: Dungeon
createEmptyDungeon = Dungeon {
    rooms = [],
    corridors = []
}

addRoom :: Dungeon -> Room -> Dungeon
addRoom dungeon room = dungeon { rooms = room : rooms dungeon  }

data Room = Room {
    position :: Point,
    size :: Size
} deriving (Show)

type Corridor = [Point]
