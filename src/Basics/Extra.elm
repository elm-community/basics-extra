module Basics.Extra exposing
    ( swap
    , maxSafeInteger, minSafeInteger, isSafeInteger
    , fractionalModBy
    , inDegrees, inRadians, inTurns
    , flip, curry, uncurry
    )

{-| Additional basic functions.


# Tuples

@docs swap


# Numbers

@docs maxSafeInteger, minSafeInteger, isSafeInteger


# Fancier Math

@docs fractionalModBy


# Angles

@docs inDegrees, inRadians, inTurns


# Higher-Order Helpers

@docs flip, curry, uncurry

-}


{-| Swaps the elements in a pair.

    swap ( 1, 2 ) == ( 2, 1 )

-}
swap : ( a, b ) -> ( b, a )
swap ( a, b ) =
    ( b, a )


{-| The maximum _safe_ value for an integer, defined as `2^53 - 1`. Anything
larger than that and behaviour becomes mathematically unsound.

    (maxSafeInteger + 1)
        == (maxSafeInteger + 2)
        == True

-}
maxSafeInteger : number
maxSafeInteger =
    2 ^ 53 - 1


{-| The minimum _safe_ value for an integer, defined as `-(2^53 - 1)`. Anything
smaller than that, and behaviour becomes mathematically unsound.

    (minSafeInteger - 1)
        == (minSafeInteger - 2)
        == True

-}
minSafeInteger : number
minSafeInteger =
    -maxSafeInteger


{-| Checks if a given integer is within the safe range, meaning it is between
`-(2^53 - 1)` and `2^53 - 1`.

    isSafeInteger 5 == True

    isSafeInteger maxSafeInteger == True

    isSafeInteger (maxSafeInteger + 1) == False

-}
isSafeInteger : Int -> Bool
isSafeInteger number =
    minSafeInteger <= number && maxSafeInteger >= number


{-| Perform [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic)
involving floating point numbers.

The sign of the result is the same as the sign of the `modulus`
in `fractionalModBy modulus x`.

    fractionalModBy 2.5 5 == 0

    fractionalModBy 2 4.5 == 0.5

    fractionalModBy 2 -4.5 == 1.5

    fractionalModBy -2 4.5 == -1.5

-}
fractionalModBy : Float -> Float -> Float
fractionalModBy modulus x =
    x - modulus * toFloat (floor (x / modulus))


{-| Convert standard Elm angles (radians) to degrees.

    inDegrees (turns 2) == 720

    inDegrees pi == 180

-}
inDegrees : Float -> Float
inDegrees angle =
    angle / degrees 1


{-| Convert standard Elm angles (radians) to radians.

    inRadians (degrees 90) == pi / 2

    inRadians (turns 1) == 2 * pi

-}
inRadians : Float -> Float
inRadians =
    identity


{-| Convert standard Elm angles (radians) to turns. One turn is equal to 360°.

    inTurns (degrees 180) == 0.5
    inTurns (3 * pi) = 1.5

-}
inTurns : Float -> Float
inTurns angle =
    angle / turns 1


{-| Flip the order of the first two arguments to a function.
-}
flip : (a -> b -> c) -> (b -> a -> c)
flip f b a =
    f a b


{-| Change how arguments are passed to a function.
This splits paired arguments into two separate arguments.
-}
curry : (( a, b ) -> c) -> a -> b -> c
curry f a b =
    f ( a, b )


{-| Change how arguments are passed to a function.
This combines two arguments into a single pair.
-}
uncurry : (a -> b -> c) -> ( a, b ) -> c
uncurry f ( a, b ) =
    f a b
