module Update exposing (Msg(..), update)

import Dict
import Model exposing (Model)


type Msg
    = UpdateValue String


isListed : Model -> String -> Model
isListed model value =
    let
        cropped : String
        cropped =
            String.slice 0 100 value
    in
    { model
        | hash = cropped
        , found = List.member cropped model.hashes
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateValue value ->
            ( isListed model value, Cmd.none )
