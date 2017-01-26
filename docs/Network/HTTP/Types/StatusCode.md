## Module Network.HTTP.Types.StatusCode

#### `ReasonPhrase`

``` purescript
data ReasonPhrase
  = Continue
  | SwitchingProtocols
  | OK
  | Created
  | Accepted
  | NonAuthoritativeInformation
  | NoContent
  | ResetContent
  | PartialContent
  | MultipleChoices
  | MovedPermanently
  | Found
  | SeeOther
  | NotModified
  | UseProxy
  | TemporaryRedirect
  | BadRequest
  | Unauthorized
  | PaymentRequired
  | Forbidden
  | NotFound
  | MethodNotAllowed
  | NotAcceptable
  | ProxyAuthenticationRequired
  | RequestTimeout
  | Conflict
  | Gone
  | LengthRequired
  | PreconditionFailed
  | PayloadTooLarge
  | URITooLong
  | UnsupportedMediaType
  | RangeNotSatisfiable
  | ExpectationFailed
  | UpgradeRequired
  | InternalServerError
  | NotImplemented
  | BadGateway
  | ServiceUnavailable
  | GatewayTimeout
  | HTTPVersionNotSupported
  | Custom String
```

A list of standard Reason Phrases that (usually) accompany a
status code number. If it's non-standard, use the 'Custom'
constructor.

##### Instances
``` purescript
Show ReasonPhrase
Eq ReasonPhrase
```

#### `reasonPhraseFromString`

``` purescript
reasonPhraseFromString :: String -> ReasonPhrase
```

Creates a 'ReasonPhrase' from a string. If the given string is a
non-standard HTTP Reason Phrase, then a 'Custom' 'ReasonPhrase'
is returned.

#### `StatusCode`

``` purescript
newtype StatusCode
  = StatusCode { code :: Int, reasonPhrase :: ReasonPhrase }
```

A type that represents an HTTP StatusCode. Consists of both it's
code (e.g.: '400'), and it's Reason Phrase (e.g.: 'Bad Request').

##### Instances
``` purescript
Show StatusCode
Eq StatusCode
Ord StatusCode
```

#### `status100`

``` purescript
status100 :: StatusCode
```

Continue

#### `status101`

``` purescript
status101 :: StatusCode
```

Switching Protocols

#### `status200`

``` purescript
status200 :: StatusCode
```

OK

#### `status201`

``` purescript
status201 :: StatusCode
```

Created

#### `status202`

``` purescript
status202 :: StatusCode
```

Accepted

#### `status203`

``` purescript
status203 :: StatusCode
```

Non-Authoritative Information

#### `status204`

``` purescript
status204 :: StatusCode
```

No Content

#### `status205`

``` purescript
status205 :: StatusCode
```

Reset Content

#### `status206`

``` purescript
status206 :: StatusCode
```

Partial Content

#### `status300`

``` purescript
status300 :: StatusCode
```

Multiple Choices

#### `status301`

``` purescript
status301 :: StatusCode
```

Moved Permanently

#### `status302`

``` purescript
status302 :: StatusCode
```

Found

#### `status303`

``` purescript
status303 :: StatusCode
```

See Other

#### `status304`

``` purescript
status304 :: StatusCode
```

Not Modified

#### `status305`

``` purescript
status305 :: StatusCode
```

Use Proxy

#### `status307`

``` purescript
status307 :: StatusCode
```

Temporary Redirect

#### `status400`

``` purescript
status400 :: StatusCode
```

Bad Request

#### `status401`

``` purescript
status401 :: StatusCode
```

Unauthorized

#### `status402`

``` purescript
status402 :: StatusCode
```

Payment Required

#### `status403`

``` purescript
status403 :: StatusCode
```

Forbidden

#### `status404`

``` purescript
status404 :: StatusCode
```

Not Found

#### `status405`

``` purescript
status405 :: StatusCode
```

Method Not Allowed

#### `status406`

``` purescript
status406 :: StatusCode
```

Not Acceptable

#### `status407`

``` purescript
status407 :: StatusCode
```

Proxy Authentication Required

#### `status408`

``` purescript
status408 :: StatusCode
```

Request Timeout

#### `status409`

``` purescript
status409 :: StatusCode
```

Conflict

#### `status410`

``` purescript
status410 :: StatusCode
```

Gone

#### `status411`

``` purescript
status411 :: StatusCode
```

Length Required

#### `status412`

``` purescript
status412 :: StatusCode
```

Precondition Failed

#### `status413`

``` purescript
status413 :: StatusCode
```

Payload Too Large

#### `status414`

``` purescript
status414 :: StatusCode
```

URI Too Long

#### `status415`

``` purescript
status415 :: StatusCode
```

Unsupported Media Type

#### `status416`

``` purescript
status416 :: StatusCode
```

Range Not Satisfiable

#### `status417`

``` purescript
status417 :: StatusCode
```

Expectation Failed

#### `status426`

``` purescript
status426 :: StatusCode
```

Upgrade Required

#### `status500`

``` purescript
status500 :: StatusCode
```

Internal Server Error

#### `status501`

``` purescript
status501 :: StatusCode
```

Not Implemented

#### `status502`

``` purescript
status502 :: StatusCode
```

Bad Gateway

#### `status503`

``` purescript
status503 :: StatusCode
```

Service Unavailable

#### `status504`

``` purescript
status504 :: StatusCode
```

Gateway Timeout

#### `status505`

``` purescript
status505 :: StatusCode
```

HTTP Version Not Supported

#### `getRecognizedStatusCodeFromInt`

``` purescript
getRecognizedStatusCodeFromInt :: Int -> Maybe StatusCode
```

Returns a standard 'StatusCode' if the given integer correlates
to a standard status code number. Returns 'Nothing' otherwise.

#### `statusCodeFromString`

``` purescript
statusCodeFromString :: String -> Maybe StatusCode
```

Returns a 'StatusCode' if the given string can be coerced into
one. The expected string format is `Status-Code SP Reason-Phrase`
(e.g.: `'400 Bad Request'`) (from RFC 2616, section 6.1).


