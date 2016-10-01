module Video4 where


mulBy7IfBig x =
    if x > 10
        then x * 7
        else x

mulBy7IfBig' x
    | x > 10    = x * 7
    | otherwise = x


mulBy7IfBig'' x =
    case (compare x 10) of
        GT -> x * 7
        _  -> x

isSmallPrime n =
    case n of
        2 -> True
        3 -> True
        5 -> True
        7 -> True
        _ -> False


isSmallPrime' 2 = True
isSmallPrime' 3 = True
isSmallPrime' 5 = True
isSmallPrime' 7 = True
isSmallPrime' _ = False
