module Model exposing (Model)

import Dict exposing (Dict)


type alias Model =
    { found : Bool
    , hashes : List String
    , hash : String
    }
