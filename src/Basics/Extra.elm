module Basics.Extra
    exposing
        ( (=>)
        , swap
        , maxSafeInteger
        , minSafeInteger
        , isSafeInteger
        )

{-| Additional basic functions.

# Tuples
@docs (=>), swap, maxSafeInteger, minSafeInteger, isSafeInteger
-}


{-| A shorthand for writing 2-tuples. Very commonly used when expressing key/value pairs
in CSS or Json encoders.
-}
(=>) : a -> b -> ( a, b )
(=>) =
    (,)


{-| Swaps the elements in a pair.

    swap ( 1, 2 ) == ( 2, 1 )

-}
swap : ( a, b ) -> ( b, a )
swap ( a, b ) =
    ( b, a )


{-| The maximum _safe_ value for an integer, defined as `2^53 - 1`. Anything
larger than that and behaviour becomes mathematically unsound.

    (maxSafeInteger + 1) == (maxSafeInteger + 2)
        == True
-}
maxSafeInteger : number
maxSafeInteger =
    9007199254740991


{-| The minimum _safe_ value for an integer, defined as `-(2^53 - 1)`. Anything
smaller than that, and behaviour becomes mathematically unsound.

    (minSafeInteger - 1) == (minSafeInteger - 2)
        == True
-}
minSafeInteger : number
minSafeInteger =
    -9007199254740991


{-| Checks if a given integer is within the safe range, meaning it is between
`-(2^53 - 1)` and `2^53 - 1`.

    isSafeInteger 5 == True
    isSafeInteger maxSafeInteger == True
    isSafeInteger (maxSafeInteger + 1) == False
-}
isSafeInteger : Int -> Bool
isSafeInteger number =
    minSafeInteger <= number && maxSafeInteger >= number
