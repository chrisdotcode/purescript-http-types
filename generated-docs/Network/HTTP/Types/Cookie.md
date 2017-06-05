## Module Network.HTTP.Types.Cookie

#### `Cookie`

``` purescript
newtype Cookie
  = Cookie { name :: String, value :: String, domain :: Maybe Host, expires :: Maybe DateTime, httpOnly :: Maybe Boolean, maxAge :: Maybe Instant, path :: URIPath Abs Unsandboxed, secure :: Maybe Boolean }
```

An type that represents an HTTP Cookie.

##### Instances
``` purescript
Show Cookie
```

#### `setName`

``` purescript
setName :: String -> Cookie -> Cookie
```

#### `setValue`

``` purescript
setValue :: String -> Cookie -> Cookie
```

#### `setDomain`

``` purescript
setDomain :: Host -> Cookie -> Cookie
```

#### `setExpires`

``` purescript
setExpires :: DateTime -> Cookie -> Cookie
```

#### `setHttpOnly`

``` purescript
setHttpOnly :: Boolean -> Cookie -> Cookie
```

#### `setMaxAge`

``` purescript
setMaxAge :: Instant -> Cookie -> Cookie
```

#### `setPath`

``` purescript
setPath :: URIPath Abs Unsandboxed -> Cookie -> Cookie
```

#### `setSecure`

``` purescript
setSecure :: Boolean -> Cookie -> Cookie
```

#### `parse`

``` purescript
parse :: String -> Cookie
```

Converts a `Set-Cookie` header value string into a 'Cookie'.

#### `stringify`

``` purescript
stringify :: Cookie -> String
```

Converts a 'Cookie' into a `Cookie` header value string.

#### `stringify'`

``` purescript
stringify' :: List Cookie -> String
```

Converts a 'List' of 'Cookie's into a `Cookie` header value.

N.B.: Please use this function instead of just calling `map stringify
myCookieList` as special processing is needed to convert a 'List' of
'Cookie's into a RFC-compliant Cookie header value string.


