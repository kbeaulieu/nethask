module Nethask.Utils.Random where

import System.Random (StdGen, mkStdGen, RandomGen, Random(randomR))

multipleRandomBetween :: (RandomGen g,  Random a) => Int -> (a, a)  -> g -> ([a], g)
multipleRandomBetween 0 range gen = ([], gen)
multipleRandomBetween n range gen =
    let (randomNumber, newGen) = randomR range gen
        (randomNumbers, finalGen) = multipleRandomBetween (n - 1) range newGen
    in (randomNumber : randomNumbers, finalGen)

-- multipleRandomBetween2 :: (RandomGen g,  Random a) => (a, a)  -> g -> ([a], g)
-- multipleRandomBetween2 range gen = ([], gen)
-- multipleRandomBetween2 range gen =
--     let (randomNumber, newGen) = randomR range gen
--         (randomNumbers, finalGen) = multipleRandom (n - 1) range finalGen
--     in (randomNumber : randomNumbers, finalGen)

-- f :: [Int]
-- f = f ++ [1]
