module View exposing (view)

import Dict
import Element
    exposing
        ( Attribute
        , Color
        , Element
        , column
        , fill
        , layout
        , modular
        , padding
        , paragraph
        , rgb255
        , row
        , spacing
        , text
        , width
        , wrappedRow
        )
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Model exposing (Model)
import Update exposing (Msg(..))



{-
   Como funciona esse site

   Nós não publicamos nesse site os dados pessoais de ninguém que foi envolvido no tal "dossiê".

   O que publicamos aqui são os hashes gerados pelo algoritmo sha-512 para os nomes dos envolvidos.

   Por exemplo, para o nome "Lucas Silva e Silva" o hash seria o seguinte:

   1fc57a19b4d02270fd8072688f06d7a1eb412ab9a5dc1b0dc9d5599e2a223d318487d6b2216f541c6c850091a1d7d0ef7d2b1bb3329a7f31f356c1afdab263ba

   Já para o nome "Lucas Silva Silva" o hash seria:

   69f17b5b1f4d2efcade487cfed412a09482c91f81a390801dfeaca0d7a5b355f6a0d266c66994740776638a227d86e11538cd96b59e2bdc298d83ed399d16872

   O campo de busca que disponibilizamos aceita os X primeiros dígitos do hash do seu nome, que pode ser calculado em diversos lugares da internet.

   Ao inserir esses dígitos, você receberá os hashes que iniciam com exatamente os mesmos dígitos, ou a mensagem que seu nome não estava na lista.

   Se receber algum hash como resultado, confira se o resultado que você recebeu é igual ao que você calculou.

   Sabemos que é um processo inconveniente, mas é a única forma de evitar que os dados sejam ainda mais expostos.
-}


darkColor : Color
darkColor =
    rgb255 32 31 26


lightColor : Color
lightColor =
    rgb255 234 232 215


fontSize : Int -> Attribute Msg
fontSize scale =
    scale
        |> modular 18 1.382
        |> round
        |> Font.size


view : Model -> Html Msg
view model =
    let
        status : String
        status =
            if String.length model.hash /= 128 then
                "Digite os 128 caracteres do hash do seu nome"

            else if model.found then
                "Está no dossiê"

            else
                "Não está no dossiê"

        form : Element Msg
        form =
            row [ width fill ]
                [ column
                    [ fontSize 1, width fill ]
                    [ Input.text []
                        { onChange = UpdateValue
                        , text = model.hash
                        , placeholder = Just (Input.placeholder [] (text "Insira aqui o hash"))
                        , label = Input.labelAbove [] (text "Hash do seu nome")
                        }
                    ]
                ]

        result : Element Msg
        result =
            row
                [ width fill ]
                [ column [ fontSize 1, width fill ] [ paragraph [] [ text status ] ] ]
    in
    layout
        [ Background.color lightColor
        , padding 64
        , Font.color darkColor
        , Font.family
            [ Font.external
                { name = "Amatic SC"
                , url = "https://fonts.googleapis.com/css2?family=Roboto&display=swap"
                }
            ]
        ]
        (row [] [ form, result ])
