module Keyboard where

import qualified Data.List as List

keyboard = ["qwertyuiop", "asdfghjkl", " zxcvbnm"]
letters = "abcdefghijklmnopqrstuvwxyz"

getCoord :: Char -> Maybe (Int, Int)
getCoord c = do
    row <- List.findIndex (\row -> elem c row) keyboard
    col <- List.elemIndex c (keyboard !! row)
    Just (row, col)