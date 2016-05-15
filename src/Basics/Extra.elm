module Basics.Extra exposing
  ( never
  )
{-| Additional basic functions

@docs never
-}

{-| The empty function.
This converts a value of type `Never` into a value of any type, which
is safe because there are no values of type `Never`.
-}
never : Never -> a
never n = never n
-- If this function is moved to Basics, the following nicer definition
-- using the private Never constructor may be used.  This actually
-- witness the emptiness of Never instead of just asserting it:
-- never (Never n) = never n
