module Network.HTTP.Types.Exchange
  ( Auth(BasicAuth)
  , Request(Request)
  , Response(Response)
  , URI'
  , http
  , https
  , defURI
  , defRequest
  , defRequest'
  , makeQuery
  -- , makeQuery' -- BREAKING: Use `URI.Query.fromString` instead.
  -- , joinQuery -- BREAKING: Use `Monoid Query` instance instead.
  , basicAuth
  , setUser
  , setPassword
  , setProtocol
  , setHostname
  , setPort
  , modifyPath
  , setPath
  , modifyQuery
  , setQuery
  , modifyFragment
  , setFragment
  , setURI
  , setMethod
  , setHeaders
  , setCookies
  , setAuth
  , setBody
  , setTimeout
  , uriToRequest'
  , uriToRequest
  , uriToRequest''
  , get
  , post
  , postWithBody
  , put
  , putWithBody
  , patch
  , patchWithBody
  , delete
  , setResponseStatusCode
  , setResponseHeaders
  , setResponseBody
  , setResponseCookies
  , fromJSONWith
  ) where

import Prelude

import Control.Alt ((<|>))
import Control.Monad.Error.Class (class MonadError, throwError)
import Data.Either (Either(..), either)
import Data.List (List)
import Data.Map as Map
import Data.Maybe (Maybe(Just, Nothing))
import Data.String.NonEmpty (nes)
import Data.Time.Duration (Milliseconds)
import Data.Tuple (Tuple(Tuple))
import Effect.Exception (Error, error)
import Network.HTTP.Types.Cookie (Cookie)
import Network.HTTP.Types.Header (Headers)
import Network.HTTP.Types.Method (Method(DELETE, GET, PATCH, POST, PUT))
import Network.HTTP.Types.StatusCode (StatusCode)
import Parsing (Parser, parseErrorMessage, runParser)
import Parsing.Combinators (optionMaybe)
import Parsing.Combinators.Array (many)
import Pathy (AbsDir, AbsFile, parseAbsDir, parseAbsFile, posixParser, rootDir)
import Type.Proxy (Proxy(..))
import URI (Authority(Authority), Fragment, HierarchicalPart(..), Host(NameAddress), Port, Query, Scheme, URI(URI), UserInfo, HierPath)
import URI.Host as Host
import URI.Host.RegName as RegName
import URI.Path as Path
import URI.Port as Port
import URI.Query as Query
import URI.Scheme as Scheme
import URI.URI (parser)

-- | A type that represents an HTTP Authentication Scheme.
data Auth = BasicAuth (Maybe String) (Maybe String)

instance showAuth :: Show Auth where
  show (BasicAuth user password) =
    "(BasicAuth " <> show user <> " " <> show password <> " )"

type URI' = URI UserInfo (Array (Tuple Host (Maybe Port))) (Maybe (Either AbsDir AbsFile)) HierPath Query Fragment

-- | A type that represents an HTTP Request.
newtype Request = Request
  { uri :: URI'
  , method :: Method
  , headers :: Headers
  , cookies :: List Cookie
  , auth ::
      Maybe Auth -- ^ If Auth information is provided in both the request.uri and request.auth, the auth in request.auth is preferred.
  , body :: String
  , timeout :: Maybe Milliseconds
  }

instance showRequest :: Show Request where
  show (Request r) = "(Request {"
    <> " uri: ("
    <> show r.uri
    <> "),"
    <> " method: ("
    <> show r.method
    <> "),"
    <> " headers: ("
    <> show r.headers
    <> "),"
    <> " cookies: ("
    <> show r.cookies
    <> "),"
    <> " auth: ("
    <> show r.auth
    <> "),"
    <> " body:"
    <> show r.body
    <> ","
    <> " timeout: ("
    <> show r.timeout
    <> "),"
    <> " })"

-- | A type that represents an HTTP Response.
newtype Response = Response
  { statusCode :: StatusCode
  , headers :: Headers
  , body :: String
  , cookies :: List Cookie
  }

instance showResponse :: Show Response where
  show (Response r) = "(Response {"
    <> " statusCode: ("
    <> show r.statusCode
    <> "),"
    <> " headers: ("
    <> show r.headers
    <> "),"
    <> " body:"
    <> show r.body
    <> ","
    <> " cookies: ("
    <> show r.cookies
    <> "),"
    <> " })"

-- | A Scheme set to `http:`.
http :: Scheme
http = Scheme.unsafeFromString "http"

-- | A Scheme set to `https:`.
https :: Scheme
https = Scheme.unsafeFromString "https"

-- | A 'default' base url useful for constructing requests. Equivalent to
-- | <http://localhost:80/>.
defURI :: URI'
defURI = URI
  http
  ( HierarchicalPartAuth
          ( Authority
              Nothing
              [ (Tuple (NameAddress $ RegName.fromString $ nes (Proxy :: _ "localhost")) (Just $ Port.unsafeFromInt 80)) ]
          )
      (Just (Left rootDir))
  )
  Nothing
  Nothing

-- | A 'default' record useful for constructing requests. Equivalent to a
-- | request that is sent to <http://localhost:80/> with the GET method, no
-- | headers, cookies, authentication, body or timeout.
defRequest
  :: { uri :: URI'
     , method :: Method
     , headers :: Headers
     , cookies :: List Cookie
     , auth :: Maybe Auth
     , body :: String
     , timeout :: Maybe Milliseconds
     }
defRequest =
  { uri: defURI
  , method: GET
  , headers: Map.empty
  , cookies: mempty
  , auth: Nothing
  , body: ""
  , timeout: Nothing
  }

-- | A 'default' request useful for constructing requests. It wraps the
-- | 'defRequest' record with the 'Request' constructor.
defRequest' :: Request
defRequest' = Request defRequest

-- | Constructs a query string from a pair (e.g.: `makeQuery animal cat` ==
-- | `?animal=cat`).
makeQuery :: String -> String -> Query
makeQuery key value = Query.fromString $ key <> "=" <> value

-- | Constructs a 'BasicAuth' from two strings. The same as the constructor,
-- | only it wraps the strings in `Just` first.
basicAuth :: String -> String -> Auth
basicAuth user password = BasicAuth (Just user) (Just password)

setUser :: String -> Auth -> Auth
setUser user (BasicAuth _ p) = BasicAuth (Just user) p

setPassword :: String -> Auth -> Auth
setPassword password (BasicAuth u _) = BasicAuth u (Just password)

setProtocol :: Scheme -> Request -> Request
setProtocol protocol (Request r@{ uri: (URI _uriScheme h q f) }) =
  Request r { uri = URI protocol h q f }

setHostname :: Host -> Request -> Request
setHostname
  hostname
  ( Request
      r@
        { uri:
            ( URI s (HierarchicalPartAuth (Authority u [ (Tuple _ p) ]) u') q
                f
            )
        }
  ) =
  Request r
    { uri = URI s
        (HierarchicalPartAuth (Authority u [ (Tuple hostname p) ]) u')
        q
        f
    }
setHostname _ r = r

setPort :: Port -> Request -> Request
setPort
  port
  ( Request
      r@
        { uri:
            ( URI s (HierarchicalPartAuth (Authority u [ (Tuple h _) ]) u') q
                f
            )
        }
  ) =
  Request r
    { uri = URI s
        (HierarchicalPartAuth (Authority u [ (Tuple h (Just port)) ]) u')
        q
        f
    }
setPort _ r = r

modifyPath :: (Either AbsDir AbsFile -> Either AbsDir AbsFile) -> Request -> Request
modifyPath fn (Request r@{ uri: (URI s (HierarchicalPartAuth a (Just u)) q f) }) =
  Request r { uri = URI s (HierarchicalPartAuth a (Just $ fn u)) q f }
modifyPath _ r = r

setPath :: Either AbsDir AbsFile -> Request -> Request
setPath = modifyPath <<< const

modifyQuery :: (Query -> Query) -> Request -> Request
modifyQuery fn (Request r@{ uri: (URI s h (Just q) f) }) =
  Request r { uri = URI s h (Just $ fn q) f }
modifyQuery _ r = r

setQuery :: Query -> Request -> Request
setQuery = modifyQuery <<< const

modifyFragment :: (Fragment -> Fragment) -> Request -> Request
modifyFragment fn (Request r@{ uri: (URI s h q (Just f)) }) =
  Request r { uri = URI s h q (Just $ fn f) }
modifyFragment _ r = r

setFragment :: Fragment -> Request -> Request
setFragment = modifyFragment <<< const

setURI :: URI' -> Request -> Request
setURI uri (Request r) = Request r { uri = uri }

setMethod :: Method -> Request -> Request
setMethod method (Request r) = Request r { method = method }

setHeaders :: Headers -> Request -> Request
setHeaders headers (Request r) = Request r { headers = headers }

setCookies :: List Cookie -> Request -> Request
setCookies cookies (Request r) = Request r { cookies = cookies }

setAuth :: Auth -> Request -> Request
setAuth auth (Request r) = Request r { auth = Just auth }

setBody :: String -> Request -> Request
setBody body (Request r) = Request r { body = body }

setTimeout :: Milliseconds -> Request -> Request
setTimeout timeout (Request r) = Request r { timeout = Just timeout }

-- | Constructs a 'Request' from a 'URI'. The request has all of the values of
-- | 'defRequest', with the URI set to the passed parameter.
uriToRequest' :: URI' -> Request
uriToRequest' uri = Request defRequest { uri = uri }

uriParser :: Parser String URI'
uriParser =
  parser
    { parseFragment: pure
    , parseHierPath: pure
    , parseHosts: many $ Tuple <$> Host.parser <*> optionMaybe Port.parser
    , parsePath: (\p -> pure $ (Left <$> parseAbsDir posixParser p) <|> (Right <$> parseAbsFile posixParser p)) <<< Path.print
    , parseQuery: pure
    , parseUserInfo: pure
    }

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter. If the
-- | uri string could not be parsed, the parsing error is thrown.
uriToRequest :: forall m. MonadError Error m => String -> m Request
uriToRequest = flip runParser uriParser >>>
  either (parseErrorMessage >>> error >>> throwError)
    (uriToRequest' >>> pure)

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter. If the
-- | uri string could not be parsed, `Nothing` is returned.
uriToRequest'' :: String -> Maybe Request
uriToRequest'' = flip runParser uriParser >>> either (const Nothing) (uriToRequest' >>> pure)

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter, and the
-- | method set to `GET`. If the uri string could not be parsed, the parsing
-- | error is thrown.
get :: forall m. MonadError Error m => String -> m Request
get uri = setMethod GET <$> uriToRequest uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter, and the
-- | method set to `POST`. If the uri string could not be parsed, the parsing
-- | error is thrown.
post :: forall m. MonadError Error m => String -> m Request
post uri = setMethod POST <$> uriToRequest uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed uri, the method set
-- | to `POST`, and the request body equal to passed body. If the uri string
-- | could not be parsed, the parsing error is thrown.
postWithBody :: forall m. MonadError Error m => String -> String -> m Request
postWithBody uri body = setBody body <$> post uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter, and the
-- | method set to `PUT`. If the uri string could not be parsed, the parsing
-- | error is thrown.
put :: forall m. MonadError Error m => String -> m Request
put uri = setMethod PUT <$> uriToRequest uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed uri, the method set
-- | to `PUT`, and the request body equal to passed body. If the uri string
-- | could not be parsed, the parsing error is thrown.
putWithBody :: forall m. MonadError Error m => String -> String -> m Request
putWithBody uri body = setBody body <$> put uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter, and the
-- | method set to `PATCH`. If the uri string could not be parsed, the parsing
-- | error is thrown.
patch :: forall m. MonadError Error m => String -> m Request
patch uri = setMethod PATCH <$> uriToRequest uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed uri, the method set
-- | to `PATCH`, and the request body equal to passed body. If the uri string
-- | could not be parsed, the parsing error is thrown.
patchWithBody :: forall m. MonadError Error m => String -> String -> m Request
patchWithBody uri body = setBody body <$> patch uri

-- | Constructs a 'Request' from a uri string. The request has all of the
-- | values of 'defRequest', with the URI set to the passed parameter, and the
-- | method set to `DELETE`. If the uri string could not be parsed, the parsing
-- | error is thrown.
delete :: forall m. MonadError Error m => String -> m Request
delete uri = setMethod DELETE <$> uriToRequest uri

setResponseStatusCode :: StatusCode -> Response -> Response
setResponseStatusCode statusCode (Response r) = Response r
  { statusCode = statusCode }

setResponseHeaders :: Headers -> Response -> Response
setResponseHeaders headers (Response r) = Response r { headers = headers }

setResponseBody :: String -> Response -> Response
setResponseBody body (Response r) = Response r { body = body }

setResponseCookies :: List Cookie -> Response -> Response
setResponseCookies cookies (Response r) = Response r { cookies = cookies }

-- | Takes a completed 'Response', extracts its string body, and converts that
-- | to our desired type using the given function. Throws an error if the
-- | conversion fails.
-- |
-- | The given function is expected to take the string body, and return a `Show
-- | errmsg => m (Left errmsg)` if the conversion fails, or a `m (Right a)` if
-- | the conversion is successful (where `m` is our `MonadError Error m`).
fromJSONWith'
  :: forall m a e
   . MonadError Error m
  => Show e
  => (String -> m (Either e a))
  -> Response
  -> m a
fromJSONWith' fn (Response r) =
  fn r.body >>= either (throwError <<< error <<< show) pure

-- | Takes a completed 'Response', extracts its string body, and converts that
-- | to our desired type using the given function. Throws an error if the
-- | conversion fails.
-- |
-- | The given function is expected to take the string body, and return a `Show
-- | errmsg => Left errmsg` if the conversion fails, or a `Right a` if the
-- | conversion is successful.
fromJSONWith
  :: forall m a e
   . MonadError Error m
  => Show e
  => (String -> Either e a)
  -> Response
  -> m a
fromJSONWith fn = fromJSONWith' (pure <<< fn)
