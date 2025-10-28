import gleam/http.{Post}
import gleam/http/request
import gleam/result
import wisp.{type Request}

pub fn handle_rpc_request(request: Request) {
  case request.method {
    Post -> post_response(request)
    _ -> wisp.method_not_allowed([Post])
  }
}

fn post_response(request: Request) {
  use body <- wisp.require_string_body(request)

  let content_type =
    request.get_header(request, "content-type")
    |> result.unwrap("application/octet-stream")

  wisp.ok()
  |> wisp.set_header("content-type", content_type)
  |> wisp.string_body(body)
}
