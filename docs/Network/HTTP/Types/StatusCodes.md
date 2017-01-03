## Module Network.HTTP.Types.StatusCodes

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

#### `status101`

``` purescript
status101 :: StatusCode
```

#### `status200`

``` purescript
status200 :: StatusCode
```

#### `status201`

``` purescript
status201 :: StatusCode
```

#### `status202`

``` purescript
status202 :: StatusCode
```

#### `status203`

``` purescript
status203 :: StatusCode
```

#### `status204`

``` purescript
status204 :: StatusCode
```

#### `status205`

``` purescript
status205 :: StatusCode
```

#### `status206`

``` purescript
status206 :: StatusCode
```

#### `status300`

``` purescript
status300 :: StatusCode
```

#### `status301`

``` purescript
status301 :: StatusCode
```

#### `status302`

``` purescript
status302 :: StatusCode
```

#### `status303`

``` purescript
status303 :: StatusCode
```

#### `status304`

``` purescript
status304 :: StatusCode
```

#### `status305`

``` purescript
status305 :: StatusCode
```

#### `status307`

``` purescript
status307 :: StatusCode
```

#### `status400`

``` purescript
status400 :: StatusCode
```

#### `status401`

``` purescript
status401 :: StatusCode
```

#### `status402`

``` purescript
status402 :: StatusCode
```

#### `status403`

``` purescript
status403 :: StatusCode
```

#### `status404`

``` purescript
status404 :: StatusCode
```

#### `status405`

``` purescript
status405 :: StatusCode
```

#### `status406`

``` purescript
status406 :: StatusCode
```

#### `status407`

``` purescript
status407 :: StatusCode
```

#### `status408`

``` purescript
status408 :: StatusCode
```

#### `status409`

``` purescript
status409 :: StatusCode
```

#### `status410`

``` purescript
status410 :: StatusCode
```

#### `status411`

``` purescript
status411 :: StatusCode
```

#### `status412`

``` purescript
status412 :: StatusCode
```

#### `status413`

``` purescript
status413 :: StatusCode
```

#### `status414`

``` purescript
status414 :: StatusCode
```

#### `status415`

``` purescript
status415 :: StatusCode
```

#### `status416`

``` purescript
status416 :: StatusCode
```

#### `status417`

``` purescript
status417 :: StatusCode
```

#### `status426`

``` purescript
status426 :: StatusCode
```

#### `status500`

``` purescript
status500 :: StatusCode
```

#### `status501`

``` purescript
status501 :: StatusCode
```

#### `status502`

``` purescript
status502 :: StatusCode
```

#### `status503`

``` purescript
status503 :: StatusCode
```

#### `status504`

``` purescript
status504 :: StatusCode
```

#### `status505`

``` purescript
status505 :: StatusCode
```

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


