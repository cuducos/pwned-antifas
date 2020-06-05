module View exposing (view)

import Dict
import Html exposing (Html, div, h3, input, p, text)
import Html.Attributes exposing (class, placeholder, size, type_)
import Html.Events exposing (onInput)
import Model exposing (Model)
import Update exposing (Msg(..))

view : Model -> Html Msg
view model =
    let
        status : { title : String, text : String, class : String }
        status =
            if String.length model.hash < 100 || model.fullName == "" then
                { title = ""
                , text = "Informe seu nome completo."
                , class = "alert alert-secondary"
                }

            else if model.found then
                { title = "Cuidado"
                , text = "Encontramos no dossiê hashes a partir do seu nome completo informado."
                , class = "alert alert-danger"
                }

            else
                { title = "Boa notícia"
                , text = "Não existem hashes que iniciem com os mesmos caracteres do hash a partir do seu nome completo informado."
                , class = "alert alert-success"
                }

        message : List (Html Msg)
        message =
            if String.isEmpty status.title then
                [ text status.text ]

            else
                [ h3 [] [ text status.title ]
                , p [] [ text status.text ]
                ]
    in
    div
        []
        [ p
            []
            [ input [ size 40, type_ "text", onInput RequestHash ] [] ]
        , div [ class status.class ] message
        ]
