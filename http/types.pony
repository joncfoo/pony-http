use "collections"

primitive Http
  fun http10(): String => "HTTP/1.0"
  fun http11(): String => "HTTP/1.1"
  fun http20(): String => "HTTP/2.0"

  fun get():     HttpMethod => HttpMethod("GET")
  fun post():    HttpMethod => HttpMethod("POST")
  fun head():    HttpMethod => HttpMethod("HEAD")
  fun put():     HttpMethod => HttpMethod("PUT")
  fun delete():  HttpMethod => HttpMethod("DELETE")
  fun trace():   HttpMethod => HttpMethod("TRACE")
  fun connect(): HttpMethod => HttpMethod("CONNECT")
  fun options(): HttpMethod => HttpMethod("OPTIONS")
  fun patch():   HttpMethod => HttpMethod("PATCH")

  fun kontinue():                        HttpStatus => HttpStatus(100, "Continue")
  fun switching_protocol():              HttpStatus => HttpStatus(101, "Switching Protocol")
  fun processing():                      HttpStatus => HttpStatus(102, "Processing")

  fun ok():                              HttpStatus => HttpStatus(200, "OK")
  fun created():                         HttpStatus => HttpStatus(201, "Created")
  fun accepted():                        HttpStatus => HttpStatus(202, "Accepted")
  fun non_authoritative():               HttpStatus => HttpStatus(203, "Non-Authoritative Information")
  fun no_content():                      HttpStatus => HttpStatus(204, "No Content")
  fun reset_content():                   HttpStatus => HttpStatus(205, "Reset Content")
  fun partial_content():                 HttpStatus => HttpStatus(206, "Partial Content")
  fun multi_status():                    HttpStatus => HttpStatus(207, "Multi-Status")
  fun already_reported():                HttpStatus => HttpStatus(208, "Already Reported")
  fun instance_manipulation_used():      HttpStatus => HttpStatus(226, "Instance Manipulation Used")

  fun multiple_choices():                HttpStatus => HttpStatus(300, "Multiple Choices")
  fun moved_permanently():               HttpStatus => HttpStatus(301, "Moved Permanently")
  fun found():                           HttpStatus => HttpStatus(302, "Found")
  fun see_other():                       HttpStatus => HttpStatus(303, "See Other")
  fun not_modified():                    HttpStatus => HttpStatus(304, "Not Modifier")
  fun use_proxy():                       HttpStatus => HttpStatus(305, "Use Proxy")
  fun temporary_redirect():              HttpStatus => HttpStatus(307, "Temporary Redirect")
  fun permanent_redirect():              HttpStatus => HttpStatus(308, "Permanent Redirect")

  fun bad_request():                     HttpStatus => HttpStatus(400, "Bad Request")
  fun unauthorized():                    HttpStatus => HttpStatus(401, "Unauthorized")
  fun payment_required():                HttpStatus => HttpStatus(402, "Payment Required")
  fun forbidden():                       HttpStatus => HttpStatus(403, "Forbidden")
  fun not_found():                       HttpStatus => HttpStatus(404, "Not Found")
  fun method_not_allowed():              HttpStatus => HttpStatus(405, "Method Not Allowed")
  fun not_acceptable():                  HttpStatus => HttpStatus(406, "Not Acceptable")
  fun proxy_authentication_required():   HttpStatus => HttpStatus(407, "Proxy Authentication Required")
  fun request_timeout():                 HttpStatus => HttpStatus(408, "Request Timeout")
  fun conflict():                        HttpStatus => HttpStatus(409, "Conflict")
  fun gone():                            HttpStatus => HttpStatus(410, "Gone")
  fun length_required():                 HttpStatus => HttpStatus(411, "Length Required")
  fun precondition_failed():             HttpStatus => HttpStatus(412, "Precondition Failed")
  fun request_entity_too_large():        HttpStatus => HttpStatus(413, "Request Entity Too Large")
  fun request_uri_too_long():            HttpStatus => HttpStatus(414, "Request URI Too Long")
  fun unsupported_media_type():          HttpStatus => HttpStatus(415, "Unsupported Media Type")
  fun requested_range_not_satisfiable(): HttpStatus => HttpStatus(416, "Requested Range Not Satisfiable")
  fun expectation_failed():              HttpStatus => HttpStatus(417, "Expectation Failed")
  fun teapot():                          HttpStatus => HttpStatus(418, "I'm a teapot")
  fun misdirected_redirect():            HttpStatus => HttpStatus(421, "Misdirected Redirect")
  fun unprocessable_entity():            HttpStatus => HttpStatus(422, "Unprocessable Entity")
  fun locked():                          HttpStatus => HttpStatus(423, "Locked")
  fun failed_dependency():               HttpStatus => HttpStatus(424, "Failed Dependency")
  fun too_early():                       HttpStatus => HttpStatus(425, "Too Early")
  fun upgrade_required():                HttpStatus => HttpStatus(426, "Upgrade Required")
  fun precondition_required():           HttpStatus => HttpStatus(428, "Precondition Required")
  fun too_many_requests():               HttpStatus => HttpStatus(429, "Too Many Requests")
  fun request_header_fields_too_large(): HttpStatus => HttpStatus(431, "Request Header Fields Too Long")
  fun unavailable_for_legal_reasons():   HttpStatus => HttpStatus(451, "Unavailable For Legal Reasons")

  fun internal_server_error():           HttpStatus => HttpStatus(500, "Internal Server Error")
  fun not_implemented():                 HttpStatus => HttpStatus(501, "Not Implemented")
  fun bad_gateway():                     HttpStatus => HttpStatus(502, "Bad Gateway")
  fun service_unavailable():             HttpStatus => HttpStatus(503, "Service Unavailable")
  fun gateway_timeout():                 HttpStatus => HttpStatus(504, "Gateway Timeout")
  fun http_version_not_supported():      HttpStatus => HttpStatus(505, "HTTP Version Not Supported")
  fun variant_also_negotiates():         HttpStatus => HttpStatus(506, "Variant Also Negotiates")
  fun insufficient_storage():            HttpStatus => HttpStatus(507, "Insufficient Storage")
  fun loop_detected():                   HttpStatus => HttpStatus(508, "Loop Detected")
  fun not_extended():                    HttpStatus => HttpStatus(510, "Not Extended")
  fun network_authentication_required(): HttpStatus => HttpStatus(511, "Network Authentication Required")


class val HttpMethod is (Stringable & Equatable[HttpMethod])
  """
  Represents an HTTP Method.
  """
  let name: String

  new val create(name': String val) =>
  """
  Create an `HttpMethod` using the uppercased `name`.
  """
    name = name'.upper()

  fun string(): String iso^ => name.string()

  fun eq(that: HttpMethod): Bool => name == that.name
  fun ne(that: HttpMethod): Bool => name != that.name


class val HttpStatus is (Stringable & Comparable[HttpStatus])
  """
  Represents an HTTP status code along with its description.
  Note that only `code` is used for comparison purposes.
  """
  let code: U16
  let description: String

  new val create(code': U16, description': String) =>
    code = code'
    description = description'

  fun is_informational(): Bool =>
  """
  Whether the status is informational: `code` is in [100..199]
  """
    (code >= 100) and (code < 200)

  fun is_successful(): Bool =>
  """
  Whether the status indicates success: `code` is in [200..299]
  """
    (code >= 200) and (code < 300)

  fun is_redirection(): Bool =>
  """
  Whether the status indicates content redirection: `code` is in [300..399]
  """
    (code >= 300) and (code < 400)

  fun is_client_error(): Bool =>
  """
  Whether the status indicates a client error: `code` is in [400..499]
  """
    (code >= 400) and (code < 500)

  fun is_server_error():  Bool =>
  """
  Whether the status indicates a server error: `code` is in [500..599]
  """
    (code >= 500) and (code < 600)

  fun string(): String iso^ => code.string()

  fun lt(that: HttpStatus): Bool => code < that.code
  fun le(that: HttpStatus): Bool => code <= that.code
  fun gt(that: HttpStatus): Bool => code > that.code
  fun ge(that: HttpStatus): Bool => code >= that.code
  fun eq(that: HttpStatus): Bool => code == that.code
  fun ne(that: HttpStatus): Bool => code != that.code


type HttpHeaders is Map[String, String]
"""
HttpHeaders is a `Map` of header names and values.
Note that header names are always stored in lowercase.
"""
