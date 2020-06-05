module Update exposing (Msg(..), update, subscriptions)

import Dict
import Model exposing (Model)
import Ports exposing (requestHash, receiveHash)

type Msg
    = RequestHash String
    | ReceiveHash String

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

updateFullName model value =
    {
        model
        | fullName = value
    }

subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveHash ReceiveHash

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestHash value ->
            ( updateFullName model value, requestHash value )
        ReceiveHash hash ->
            ( isListed model hash, Cmd.none )
