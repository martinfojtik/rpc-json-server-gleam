import gleam/dynamic/decode.{type Dynamic}
import gleam/http/request
import gleam/json
import gleam/result
import jsonrpc
import wisp

pub fn post_response(base_request: request.Request(wisp.Connection)) {
  use body <- wisp.require_string_body(base_request)

  let request_result =
    json.parse(body, jsonrpc.message_decoder())
    |> result.map_error(jsonrpc.json_error)
    |> result.map_error(jsonrpc.error_response(_, jsonrpc.NullId))
    |> result.map_error(jsonrpc.error_response_to_json(
      _,
      jsonrpc.nothing_to_json,
    ))

  case request_result {
    Ok(msg) -> {
      case msg {
        jsonrpc.RequestMessage(request) -> handle_request(base_request, request)
        jsonrpc.NotificationMessage(notification) -> handle_notification(base_request, notification)
        _ -> wisp.bad_request("invalid type")
      }
    }
    Error(_) -> wisp.internal_server_error()
  }
}

fn handle_request(
  _base_request: request.Request(wisp.Connection),
  json_request: jsonrpc.Request(Dynamic),
) {
  case json_request.method {
    "get_pet" -> {
      let object = json.object([
        #("name", json.string("Pac-Man"))
      ])

      wisp.json_response(json.to_string(object), 200)
    }

    _ -> wisp.bad_request("invalid method")
  }
}

fn handle_notification(
  _base_request: request.Request(wisp.Connection),
  notification: jsonrpc.Notification(Dynamic),
) {
  case notification.method {
    _ -> wisp.bad_request("invalid notification")
  }
}
