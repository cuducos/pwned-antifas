port module Ports exposing (requestHash, receiveHash)

port requestHash : String -> Cmd msg
port receiveHash : (String -> msg) -> Sub msg
