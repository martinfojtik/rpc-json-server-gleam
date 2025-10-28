import gleam/http.{Get}
import gleam/http/response
import rpc/handler
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use req <- middleware(req)

  case wisp.path_segments(req) {
    ["ping"] -> ping(req)
    ["rpc"] -> handler.handle_rpc_request(req)
    _ -> not_found()
  }
}

fn middleware(
  req: Request,
  handle_request: fn(Request) -> Response,
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)

  use <- default_responses

  handle_request(req)
}

fn default_responses(handle_request: fn() -> Response) {
    let response = handle_request()

    response.set_header(response, "made-with", "Gleam")
}

fn ping(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  wisp.ok()
  |> wisp.set_header("content-type", "text/plain")
  |> wisp.string_body("Pong!")
}

fn not_found() {
  wisp.not_found()
  |> wisp.set_header("content-type", "text/plain")
  |> wisp.string_body("Not found.")
}
