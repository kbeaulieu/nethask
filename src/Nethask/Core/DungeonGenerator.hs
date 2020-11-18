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
    |> dungeon

initState :: DungeonConfig -> GenerationState
initState config = GenerationState {
    config = config,
    nextGenerator = randomNumberGenerator config,
    dungeon = createEmptyDungeon
}

generateRandomRooms :: GenerationState -> GenerationState
generateRandomRooms state =
    let (numberOfRoom, newGenerator) = randomR (3, 7) (nextGenerator state)
        state' = state { nextGenerator = newGenerator }
    in  gen state' numberOfRoom
    where
        gen :: GenerationState -> Int -> GenerationState
        gen state 0 = state
        gen state n = gen (generateRandomRoom state) (n - 1)

generateRandomRoom :: GenerationState -> GenerationState
generateRandomRoom state =
    let (numbers, newGenerator) = multipleRandomBetween 4 (1, 10) (nextGenerator state)
        newRoom = Room (numbers !! 0, numbers !! 1) (numbers !! 2, numbers !! 3)
        dungeonWithRoom = addRoom (dungeon state) newRoom
    in  state { nextGenerator = newGenerator, dungeon = dungeonWithRoom }

{-
Rose tree
Root == entrance,
at least one leaf per node until min # of rooms
Children at random distance and direction (not too far)
If rooms collide, retry
Add a door between side-by-side rooms.

-}
