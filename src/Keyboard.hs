module Keyboard where

import Data.List (findIndex, elemIndex)

keyboard = ["qwertyuiop", "asdfghjkl", " zxcvbnm"]
letters = "abcdefghijklmnopqrstuvwxyz"

getCoord :: Char -> Maybe (Int, Int)
getCoord c = do
    row <- findIndex (\row -> elem c row) keyboard
    col <- elemIndex c (keyboard !! row)
    Just (row, col)