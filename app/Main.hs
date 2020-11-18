module Main where

import Nethask.Core.DungeonGenerator (DungeonConfig(..), generateDungeon)
import System.Random (newStdGen)

main :: IO ()
main = do
    generator <- newStdGen
    let config = DungeonConfig generator
    putStrLn $ show $ generateDungeon config
