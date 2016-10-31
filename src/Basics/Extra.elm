module Basics.Extra
    exposing
        ( (=>)
        , swap
        )

{-| Additional basic functions.

# Tuples
@docs (=>), swap
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
