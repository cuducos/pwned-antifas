module Update exposing (Msg(..), update)

import Dict
import Model exposing (Model)


type Msg
    = UpdateValue String


isListed : Model -> String -> Model
isListed model value =
    { model
        | hash = value
        , found = List.member value model.hashes
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateValue value ->
            ( isListed model value, Cmd.none )
