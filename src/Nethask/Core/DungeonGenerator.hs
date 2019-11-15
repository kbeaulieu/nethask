module Nethask.Core.DungeonGenerator where

import Nethask.Core.Dungeon (Dungeon(..), Room(..), createEmptyDungeon, addRoom)
import Nethask.Core.World (WorldConfig)
import Nethask.Utils.Random (multipleRandomBetween)
import System.Random (StdGen, mkStdGen, RandomGen, Random(randomR))
import Flow

newtype DungeonConfig = DungeonConfig {
    randomNumberGenerator :: StdGen
} deriving (Show)

data GenerationState = GenerationState {
    config :: DungeonConfig,
    nextGenerator :: StdGen,
    dungeon :: Dungeon
} deriving (Show)

generateDungeon :: DungeonConfig -> Dungeon
generateDungeon config =
    config
    |> initState
    |> generateRandomRooms
    |> dungeon

initState :: DungeonConfig -> GenerationState
initState config = GenerationState {
    config = config,
    nextGenerator = randomNumberGenerator config,
    dungeon = createEmptyDungeon
}

generateRandomRooms :: GenerationState -> GenerationState
generateRandomRooms state =
    let (numbers, newGenerator) = nextGenerator state |> multipleRandomBetween 4 (1, 10)
        newRoom = Room (numbers !! 0, numbers !! 1) (numbers !! 2, numbers !! 3)
        dungeonWithRoom = addRoom (dungeon state) newRoom
    in  state { nextGenerator = newGenerator, dungeon = dungeonWithRoom }
