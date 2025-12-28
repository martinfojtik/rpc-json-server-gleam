import gleam/http.{Post}
import gleam/http/request
import gleam/json
import gleam/result
import jsonrpc
import wisp.{type Request}
import gleam/option.{type Option, None, Some}
import gleam/dynamic/decode.{type Dynamic}

pub fn handle_rpc_request(request: Request) {
  case request.method {
    Post -> post_response(request)
    _ -> wisp.method_not_allowed([Post])
  }
}

fn post_response(base_request: request.Request(wisp.Connection)) {
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
    m if m == "ping" -> {
      wisp.json_response("{\"status\": \"OK\"}", 200)
    }
    _ -> wisp.bad_request("invalid method")
  }


}

fn handle_notification(
  _base_request: request.Request(wisp.Connection),
  notification: jsonrpc.Notification(Dynamic),
) {
  case notification.method {
    // m if m == method.notification_resources_list_changed -> todo
    // m if m == method.notification_resource_updated -> todo
    // m if m == method.notification_prompts_list_changed -> todo
    // m if m == method.notification_tools_list_changed -> todo
    _ -> wisp.ok()
  }
}
