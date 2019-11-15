module Main where

import Nethask.Core.DungeonGenerator
import Nethask.Core.Common
import System.Random

main :: IO ()
main = do
    generator <- getStdGen
    let config = DungeonConfig generator
    putStrLn $ show $ generateDungeon config

