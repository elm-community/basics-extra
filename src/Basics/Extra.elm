module Basics.Extra
    exposing
        ( never
        )

{-| Additional basic functions

@docs never
-}


{-| The empty function.
This converts a value of type
[`Never`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#Never)
into a value of any type, which is safe because there are no values of
type `Never`. Useful in certain situations as argument to
[`Task.perform`](http://package.elm-lang.org/packages/elm-lang/core/latest/Task#perform)
and
[`Html.App.map`](http://package.elm-lang.org/packages/elm-lang/html/latest/Html-App#map).

*Note:* To use this function, its argument need not be literally of type `Never`.
It suffices if it is a fully polymorphic value. For example, this works:
`Process.sleep >> Task.perform never (\() -> ...)`, because the output of
[`Process.sleep`](http://package.elm-lang.org/packages/elm-lang/core/latest/Process#sleep)
is fully polymorphic in the `x` of `Task x ()`. 
-}
never : Never -> a
never n =
    never n
-- If this function is moved to Basics, the following nicer definition
-- using the private Never constructor may be used.  This actually
-- witnesses the emptiness of Never instead of just asserting it:
--
-- never (Never n) =
--     never n
