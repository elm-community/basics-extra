module Tests exposing (suite)

import Basics.Extra exposing (fractionalModBy, inRadians, inTurns)
import Expect exposing (Expectation, FloatingPointTolerance(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Basics.Extra additional doc tests"
        [ fractionalModByDocTests
        , inRadiansDocTests
        , inTurnsDocTests
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
