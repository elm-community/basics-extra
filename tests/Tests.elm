module Tests exposing (suite)

import Basics.Extra exposing (fractionalModBy, inRadians, inTurns, orderBy, toOrder)
import Expect exposing (Expectation, FloatingPointTolerance(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Basics.Extra additional doc tests"
        [ fractionalModByDocTests
        , inRadiansDocTests
        , inTurnsDocTests
        , orderByTests
        , toOrderTests
        ]


expectAlmostEqual : Float -> Float -> Expectation
expectAlmostEqual =
    Expect.within (Absolute 1.0e-20)


fractionalModByDocTests : Test
fractionalModByDocTests =
    describe "fractionalModBy"
        [ test "example 1" <|
            \() -> fractionalModBy 2 4.5 |> expectAlmostEqual 0.5
        , test "example 2" <|
            \() -> fractionalModBy 2 -4.5 |> expectAlmostEqual 1.5
        , test "example 3" <|
            \() -> fractionalModBy -2 4.5 |> expectAlmostEqual -1.5
        ]


inRadiansDocTests : Test
inRadiansDocTests =
    describe "inRadians"
        [ test "example 1" <|
            \() -> inRadians (degrees 90) |> expectAlmostEqual (pi / 2)
        , test "example 2" <|
            \() -> inRadians (turns 1) |> expectAlmostEqual (2 * pi)
        ]


inTurnsDocTests : Test
inTurnsDocTests =
    describe "inTurns"
        [ test "example 1" <|
            \() -> inTurns (degrees 180) |> expectAlmostEqual 0.5
        , test "example 2" <|
            \() -> inTurns (3 * pi) |> expectAlmostEqual 1.5
        ]


orderByTests : Test
orderByTests =
    describe "orderBy"
        [ test "this will fail" <| \() -> Expect.fail "todo" ]


type alias ToOrderProduct =
    { field : Int }


type ToOrderSum
    = A
    | B


toOrderTests : Test
toOrderTests =
    describe "toOrder"
        [ test "use a type alias accessor to create an ordering function for that type alias" <|
            \() ->
                let
                    order : ToOrderProduct -> ToOrderProduct -> Order
                    order =
                        toOrder .field

                    unsorted : List ToOrderProduct
                    unsorted =
                        [ { field = 9 }
                        , { field = 8 }
                        , { field = 7 }
                        ]

                    sorted : List ToOrderProduct
                    sorted =
                        [ { field = 7 }
                        , { field = 8 }
                        , { field = 9 }
                        ]
                in
                List.sortWith order unsorted |> Expect.equalLists sorted
        , test "create a custom ordering function based on a sum type, and sort with it" <|
            \() ->
                let
                    order : ToOrderSum -> ToOrderSum -> Order
                    order a b =
                        case ( a, b ) of
                            ( A, A ) ->
                                EQ

                            ( B, B ) ->
                                EQ

                            ( A, _ ) ->
                                LT

                            ( B, _ ) ->
                                GT

                    unsorted : List ToOrderSum
                    unsorted =
                        [ B, A, B, A, B ]

                    sorted : List ToOrderSum
                    sorted =
                        [ A, A, B, B, B ]
                in
                List.sortWith order unsorted |> Expect.equalLists sorted
        ]
