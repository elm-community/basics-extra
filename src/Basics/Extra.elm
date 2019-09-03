module Basics.Extra exposing
    ( swap
    , maxSafeInteger, minSafeInteger, isSafeInteger
    , fractionalModBy, safeModBy, safeRemainderBy, safeDivide, safeIntegerDivide
    , inDegrees, inRadians, inTurns
    , flip, curry, uncurry
    )

{-| Additional basic functions.


# Tuples

@docs swap


# Numbers

@docs maxSafeInteger, minSafeInteger, isSafeInteger


# Fancier Math

@docs fractionalModBy, safeModBy, safeRemainderBy, safeDivide, safeIntegerDivide


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


{-| Perform [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic)
that doesn't crash the app if the `b` argument in `a % b` is zero. We instead return `Nothing`.

    safeModBy 2 4 == Just 0

    safeModBy 2 5 == Just 1

    -- the interesting part
    safeModBy 0 4 == Nothing

In many cases it makes sense to [return zero](https://www.hillelwayne.com/post/divide-by-zero/) as a default.
You can do that by defining your own version - might be nicer to use because of returning straight `Int`!

    modBy_ : Int -> Int -> Int
    modBy_ modulus x =
        safeModBy modulus x
            |> Maybe.withDefault 0

    modBy_ 2 4 == 0

    modBy_ 2 5 == 1

    -- the interesting part
    modBy_ 0 4 == 0

Use [`safeRemainderBy`](#safeRemainderBy) for a different treatment of negative
numbers, or read Daan Leijen’s [Division and Modulus for Computer Scientists][dm]
for more information.

[dm]: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf

-}
safeModBy : Int -> Int -> Maybe Int
safeModBy modulus x =
    if modulus == 0 then
        Nothing

    else
        Just <| modBy modulus x


{-| Get the remainder after division.

This version doesn't crash the app if the `b` argument in `a % b` is zero. We instead return `Nothing`.

    safeRemainderBy 2 4 == Just 0

    safeRemainderBy 2 5 == Just 1

    -- the interesting part
    safeRemainderBy 0 4 == Nothing

In many cases it makes sense to [return zero](https://www.hillelwayne.com/post/divide-by-zero/) as a default.
You can do that by defining your own version - might be nicer to use because of returning straight `Int`!

    remainderBy_ : Int -> Int -> Int
    remainderBy_ divisor x =
        safeRemainderBy divisor x
            |> Maybe.withDefault 0

    remainderBy_ 2 4 == 0

    remainderBy_ 2 5 == 1

    -- the interesting part
    remainderBy_ 0 4 == 0

Use [`safeModBy`](#safeModBy) for a different treatment of negative
numbers, or read Daan Leijen’s [Division and Modulus for Computer Scientists][dm]
for more information.

[dm]: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf

-}
safeRemainderBy : Int -> Int -> Maybe Int
safeRemainderBy divisor x =
    if divisor == 0 then
        Nothing

    else
        Just <| remainderBy divisor x


{-| Floating-point division (like Elm's `/` operator), [returning zero](https://www.hillelwayne.com/post/divide-by-zero/)
if the divisor is zero.

    safeDivide 5 2 == 2.5

    -- the interesting part
    safeDivide 5 0 == 0

-}
safeDivide : Float -> Float -> Float
safeDivide x y =
    if y == 0 then
        0

    else
        x / y


{-| Integer division (like Elm's `//` operator), [returning zero](https://www.hillelwayne.com/post/divide-by-zero/)
if the divisor is zero.

    safeIntegerDivide 5 2 == 2

    -- the interesting part
    safeIntegerDivide 5 0 == 0

-}
safeIntegerDivide : Int -> Int -> Int
safeIntegerDivide x y =
    if y == 0 then
        0

    else
        x // y


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
