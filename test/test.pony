use "ponytest"
use "http"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(t: PonyTest) =>
    t(_TestVersion)
    t(_TestMethod)
    t(_TestStatus)


class _TestVersion is UnitTest
  fun name(): String => "Http"
  fun apply(h: TestHelper) =>
    h.assert_eq[String]("HTTP/1.0", Http.http10())
    h.assert_eq[String]("HTTP/1.1", Http.http11())
    h.assert_eq[String]("HTTP/2.0", Http.http20())

class _TestMethod is UnitTest
  fun name(): String => "HttpMethod"
  fun apply(h: TestHelper) =>
    // Stringable
    h.assert_eq[String]("GET", Http.get().string())

    // Equatable
    h.assert_eq[HttpMethod](HttpMethod("get"), Http.get())
    h.assert_ne[HttpMethod](Http.get(), Http.post())


class _TestStatus is UnitTest
  fun name(): String => "HttpStatus"
  fun apply(h: TestHelper) =>
    // Stringable
    h.assert_eq[String]("404", Http.not_found().string())

    // Equatable
    h.assert_eq[HttpStatus](HttpStatus(404, "Where did the soda go!?"), Http.not_found())
    h.assert_ne[HttpStatus](HttpStatus(403, "Stop that!"), Http.ok())
