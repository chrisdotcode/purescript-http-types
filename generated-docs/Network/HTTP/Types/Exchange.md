## Module Network.HTTP.Types.Exchange

#### `Auth`

``` purescript
data Auth
  = BasicAuth (Maybe String) (Maybe String)
```

A type that represents an HTTP Authentication Scheme.

##### Instances
``` purescript
Show Auth
```

#### `Request`

``` purescript
newtype Request
  = Request { uri :: URI, method :: Method, headers :: Headers, cookies :: List Cookie, auth :: Maybe Auth, body :: String, timeout :: Maybe Milliseconds }
```

A type that represents an HTTP Request.

##### Instances
``` purescript
Show Request
```

#### `Response`

``` purescript
newtype Response
  = Response { statusCode :: StatusCode, headers :: Headers, body :: String, cookies :: List Cookie }
```

A type that represents an HTTP Response.

##### Instances
``` purescript
Show Response
```

#### `http`

``` purescript
http :: URIScheme
```

A URIScheme set to `http:`.

#### `https`

``` purescript
https :: URIScheme
```

A URIScheme set to `https:`.

#### `defURI`

``` purescript
defURI :: URI
```

A 'default' base url useful for constructing requests. Equivalent to
<http://localhost:80/>.

#### `defRequest`

``` purescript
defRequest :: { uri :: URI, method :: Method, headers :: Headers, cookies :: List Cookie, auth :: Maybe Auth, body :: String, timeout :: Maybe Milliseconds }
```

A 'default' record useful for constructing requests. Equivalent to a
request that is sent to <http://localhost:80/> with the GET method, no
headers, cookies, authentication, body or timeout.

#### `defRequest'`

``` purescript
defRequest' :: Request
```

A 'default' request useful for constructing requests. It wraps the
'defRequest' record with the 'Request' constructor.

#### `makeQuery`

``` purescript
makeQuery :: String -> String -> Query
```

Constructs a query string from a pair (e.g.: `makeQuery animal cat` ==
`?animal=cat`).

#### `makeQuery'`

``` purescript
makeQuery' :: String -> Query
```

Constructs a query string from a single string (e.g.: `makeQuery' hungry` ==
`?hungry`).

#### `joinQuery`

``` purescript
joinQuery :: Query -> Query -> Query
```

Kinda-sorta like a Monoid over Query; combines two queries (e.q.: `
joinQuery (?animal=cat) (?hungry)` == `?hungry&animal=cat`).

#### `basicAuth`

``` purescript
basicAuth :: String -> String -> Auth
```

Constructs a 'BasicAuth' from two strings. The same as the constructor,
only it wraps the strings in `Just` first.

#### `setUser`

``` purescript
setUser :: String -> Auth -> Auth
```

#### `setPassword`

``` purescript
setPassword :: String -> Auth -> Auth
```

#### `setProtocol`

``` purescript
setProtocol :: URIScheme -> Request -> Request
```

#### `setHostname`

``` purescript
setHostname :: Host -> Request -> Request
```

#### `setPort`

``` purescript
setPort :: Port -> Request -> Request
```

#### `modifyPath`

``` purescript
modifyPath :: (URIPathAbs -> URIPathAbs) -> Request -> Request
```

#### `setPath`

``` purescript
setPath :: URIPathAbs -> Request -> Request
```

#### `modifyQuery`

``` purescript
modifyQuery :: (Query -> Query) -> Request -> Request
```

#### `setQuery`

``` purescript
setQuery :: Query -> Request -> Request
```

#### `modifyFragment`

``` purescript
modifyFragment :: (Fragment -> Fragment) -> Request -> Request
```

#### `setFragment`

``` purescript
setFragment :: Fragment -> Request -> Request
```

#### `setURI`

``` purescript
setURI :: URI -> Request -> Request
```

#### `setMethod`

``` purescript
setMethod :: Method -> Request -> Request
```

#### `setHeaders`

``` purescript
setHeaders :: Headers -> Request -> Request
```

#### `setCookies`

``` purescript
setCookies :: List Cookie -> Request -> Request
```

#### `setAuth`

``` purescript
setAuth :: Auth -> Request -> Request
```

#### `setBody`

``` purescript
setBody :: String -> Request -> Request
```

#### `setTimeout`

``` purescript
setTimeout :: Milliseconds -> Request -> Request
```

#### `uriToRequest'`

``` purescript
uriToRequest' :: URI -> Request
```

Constructs a 'Request' from a 'URI'. The request has all of the values of
'defRequest', with the URI set to the passed parameter.

#### `uriToRequest`

``` purescript
uriToRequest :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter. If the
uri string could not be parsed, the parsing error is thrown.

#### `uriToRequest''`

``` purescript
uriToRequest'' :: String -> Maybe Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter. If the
uri string could not be parsed, `Nothing` is returned.

#### `get`

``` purescript
get :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter, and the
method set to `GET`. If the uri string could not be parsed, the parsing
error is thrown.

#### `post`

``` purescript
post :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter, and the
method set to `POST`. If the uri string could not be parsed, the parsing
error is thrown.

#### `postWithBody`

``` purescript
postWithBody :: forall m. MonadError Error m => String -> String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed uri, the method set
to `POST`, and the request body equal to passed body. If the uri string
could not be parsed, the parsing error is thrown.

#### `put`

``` purescript
put :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter, and the
method set to `PUT`. If the uri string could not be parsed, the parsing
error is thrown.

#### `putWithBody`

``` purescript
putWithBody :: forall m. MonadError Error m => String -> String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed uri, the method set
to `PUT`, and the request body equal to passed body. If the uri string
could not be parsed, the parsing error is thrown.

#### `patch`

``` purescript
patch :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter, and the
method set to `PATCH`. If the uri string could not be parsed, the parsing
error is thrown.

#### `patchWithBody`

``` purescript
patchWithBody :: forall m. MonadError Error m => String -> String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed uri, the method set
to `PATCH`, and the request body equal to passed body. If the uri string
could not be parsed, the parsing error is thrown.

#### `delete`

``` purescript
delete :: forall m. MonadError Error m => String -> m Request
```

Constructs a 'Request' from a uri string. The request has all of the
values of 'defRequest', with the URI set to the passed parameter, and the
method set to `DELETE`. If the uri string could not be parsed, the parsing
error is thrown.

#### `setResponseStatusCode`

``` purescript
setResponseStatusCode :: StatusCode -> Response -> Response
```

#### `setResponseHeaders`

``` purescript
setResponseHeaders :: Headers -> Response -> Response
```

#### `setResponseBody`

``` purescript
setResponseBody :: String -> Response -> Response
```

#### `setResponseCookies`

``` purescript
setResponseCookies :: List Cookie -> Response -> Response
```

#### `fromJSONWith`

``` purescript
fromJSONWith :: forall m a e. MonadError Error m => Show e => (String -> Either e a) -> Response -> m a
```

Takes a completed 'Response', extracts its string body, and converts that
to our desired type using the given function. Throws an error if the
conversion fails.

The given function is expected to take the string body, and return a `Show
errmsg => Left errmsg` if the conversion fails, or a `Right a` if the
conversion is successful.


