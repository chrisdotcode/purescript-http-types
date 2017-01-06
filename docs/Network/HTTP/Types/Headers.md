## Module Network.HTTP.Types.Headers

#### `HeaderValue`

``` purescript
data HeaderValue
  = HVStr String
  | HVList (NonEmptyList String)
```

A header value is either a string by itself (e.g.: `'text/html;
charset=UTF-8'`), or a non-empty list of strings in the case of a
header that might be included multiple different times (e.g.: the
`Vary` header with values `['Origin', 'Accept-Encoding']`).

##### Instances
``` purescript
Show HeaderValue
Eq HeaderValue
Ord HeaderValue
```

#### `HeaderName`

``` purescript
data HeaderName
  = AIM
  | Accept
  | AcceptAdditions
  | AcceptCharset
  | AcceptEncoding
  | AcceptFeatures
  | AcceptLanguage
  | AcceptRanges
  | Age
  | Allow
  | Alternates
  | AuthenticationInfo
  | Authorization
  | CExt
  | CMan
  | COpt
  | CPEP
  | CPEPInfo
  | CacheControl
  | Connection
  | ContentBase
  | ContentDisposition
  | ContentEncoding
  | ContentID
  | ContentLanguage
  | ContentLength
  | ContentLocation
  | ContentMD5
  | ContentRange
  | ContentScriptType
  | ContentStyleType
  | ContentType
  | ContentVersion
  | Cookie
  | Cookie2
  | DAV
  | Date
  | DefaultStyle
  | DeltaBase
  | Depth
  | DerivedFrom
  | Destination
  | DifferentialID
  | Digest
  | ETag
  | Expect
  | Expires
  | Ext
  | From
  | GetProfile
  | Host
  | IM
  | If
  | IfMatch
  | IfModifiedSince
  | IfNoneMatch
  | IfRange
  | IfUnmodifiedSince
  | KeepAlive
  | Label
  | LastModified
  | Link
  | Location
  | LockToken
  | MIMEVersion
  | Man
  | MaxForwards
  | Meter
  | Negotiate
  | Opt
  | OrderingType
  | Overwrite
  | P3P
  | PEP
  | PICSLabel
  | PepInfo
  | Position
  | Pragma
  | ProfileObject
  | Protocol
  | ProtocolInfo
  | ProtocolQuery
  | ProtocolRequest
  | ProxyAuthenticate
  | ProxyAuthenticationInfo
  | ProxyAuthorization
  | ProxyFeatures
  | ProxyInstruction
  | Public
  | Range
  | Referer
  | RetryAfter
  | Safe
  | SecurityScheme
  | Server
  | SetCookie
  | SetCookie2
  | SetProfile
  | SoapAction
  | StatusURI
  | SurrogateCapability
  | SurrogateControl
  | TCN
  | TE
  | Timeout
  | Trailer
  | TransferEncoding
  | URI
  | Upgrade
  | UserAgent
  | VariantVary
  | Vary
  | Via
  | WWWAuthenticate
  | WantDigest
  | Warning
  | Custom String
```

A list of standard headers. If it's non-standard, use the
'Custom' constructor.

##### Instances
``` purescript
Show HeaderName
Eq HeaderName
Ord HeaderName
```

#### `headerNameFromString`

``` purescript
headerNameFromString :: String -> HeaderName
```

Creates a 'HeaderName' from a string. If the given string is a
non-standard HTTP header name, then a 'Custom' 'HeaderName' is
returned.

#### `Headers`

``` purescript
type Headers = Map HeaderName HeaderValue
```

A type alias for a group of HTTP headers.


