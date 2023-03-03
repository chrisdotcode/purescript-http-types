module Network.HTTP.Types.Cookie
  ( Cookie(Cookie)
  , setName
  , setValue
  , setDomain
  , setExpires
  , setHttpOnly
  , setMaxAge
  , setPath
  , setSecure
  , parse
  , stringify
  , stringify'
  ) where

import Control.Alt ((<|>))
import Control.Monad.Except (runExcept)
import Data.DateTime (DateTime)
import Data.DateTime.Instant (Instant, instant)
import Data.Either (Either(Left, Right), either)
import Data.JSDate (toDateTime)
import Data.List (List, intercalate)
import Data.Maybe (Maybe(Just, Nothing), fromMaybe)
import Data.String.NonEmpty as NES
import Data.Time.Duration (Milliseconds(Milliseconds))
import Foreign (Foreign, readNullOrUndefined, readUndefined, unsafeFromForeign)
import Parsing (runParser)
import Pathy (Abs, AbsDir, AbsFile, parseAbsDir, parseAbsFile, posixParser, rootDir)
import Prelude (class Show, const, identity, map, show, ($), (<$>), (<<<), (<>), (>>=), (>>>))
import URI (Host(NameAddress), Path)
import URI.Host (parser)
import URI.Host.RegName as RegName

-- | The cookie object we get back from 'parseImpl'.
newtype JSCookie = JSCookie
  { key :: String
  , value :: String
  -- You would expect the following fields to have the types that are
  -- commented on them, however those are what the PureScript
  -- representation of the type would be. Since JS has no types, we
  -- represent them as whatever JS gives back, which is `Undefined|a`,
  -- a.k.a., `Foreign`.
  , domain :: Foreign -- ^ Undefined String
  , expires :: Foreign -- ^ Undefined JSDate
  , httpOnly :: Foreign -- ^ Undefined Boolean
  , maxAge :: Foreign -- ^ Undefined Number
  , path :: Foreign -- ^ Undefined String
  , secure :: Foreign -- ^ Undefined Boolean
  }

-- | An type that represents an HTTP Cookie.
newtype Cookie = Cookie
  { name :: String
  , value :: String
  , domain :: Maybe Host
  , expires :: Maybe DateTime
  , httpOnly :: Maybe Boolean
  , maxAge :: Maybe Instant
  , path :: Either AbsDir AbsFile
  , secure :: Maybe Boolean
  }

instance showCookie :: Show Cookie where
  show (Cookie c) = "(Cookie {"
    <> " name:"
    <> show c.name
    <> ","
    <> " value:"
    <> show c.value
    <> ","
    <> " domain: ("
    <> show c.domain
    <> "),"
    <> " expires: ("
    <> show c.expires
    <> "),"
    <> " httpOnly: ("
    <> show c.httpOnly
    <> "),"
    <> " maxAge: ("
    <> show c.maxAge
    <> "),"
    <> " path: ("
    <> show c.path
    <> "),"
    <> " secure: ("
    <> show c.secure
    <> "),"
    <> " })"

setName :: String -> Cookie -> Cookie
setName name (Cookie c) = Cookie c { name = name }

setValue :: String -> Cookie -> Cookie
setValue value (Cookie c) = Cookie c { value = value }

setDomain :: Host -> Cookie -> Cookie
setDomain domain (Cookie c) = Cookie c { domain = Just domain }

setExpires :: DateTime -> Cookie -> Cookie
setExpires expires (Cookie c) = Cookie c { expires = Just expires }

setHttpOnly :: Boolean -> Cookie -> Cookie
setHttpOnly httpOnly (Cookie c) = Cookie c { httpOnly = Just httpOnly }

setMaxAge :: Instant -> Cookie -> Cookie
setMaxAge maxAge (Cookie c) = Cookie c { maxAge = Just maxAge }

setPath :: Either AbsDir AbsFile -> Cookie -> Cookie
setPath path (Cookie c) = Cookie c { path = path }

setSecure :: Boolean -> Cookie -> Cookie
setSecure secure (Cookie c) = Cookie c { secure = Just secure }

-- | Converts a 'JSCookie' to a PureScript 'Cookie'.
toCookie :: JSCookie -> Cookie
toCookie (JSCookie c) = Cookie
  { name: c.key
  , value: c.value
  -- XXX If a host can't be parsed, just convert the string domain value into a NameAddress and return it;
  -- but maybe we should throw here?
  , domain: (\d -> either (const $ NameAddress $ RegName.fromString d) identity $ runParser (NES.toString d) parser)
      <$>
        (fromUndefined c.domain >>= NES.fromString)
  , expires: fromUndefined c.expires >>= toDateTime
  , httpOnly: fromUndefined c.httpOnly
  , maxAge: fromUndefined c.maxAge >>= (Milliseconds >>> instant)
  , path: fromMaybe (Left rootDir) $ fromNullOrUndefined c.path >>= \p ->
      (Left <$> parseAbsDir posixParser p) <|> (Right <$> parseAbsFile posixParser p)
  , secure: fromUndefined c.secure
  }
  where
  -- This `unsafeFromForeign` here means we're always trusting tough-cookie to parse values properly;
  -- I think that's a pretty safe assumption.
  fromUndefined :: forall a. Foreign -> Maybe a
  fromUndefined = either (const Nothing) (unsafeFromForeign <$> _) <<< runExcept
    <<< readUndefined
  fromNullOrUndefined = either (const Nothing) (unsafeFromForeign <$> _)
    <<< runExcept
    <<< readNullOrUndefined

foreign import parseImpl :: String -> JSCookie

-- | Converts a `Set-Cookie` header value string into a 'Cookie'.
parse :: String -> Cookie
parse = parseImpl >>> toCookie

-- | Converts a 'Cookie' into a `Cookie` header value string.
stringify :: Cookie -> String
stringify (Cookie { name, value }) = name <> "=" <> value

-- | Converts a 'List' of 'Cookie's into a `Cookie` header value.
-- |
-- | N.B.: Please use this function instead of just calling `map stringify
-- | myCookieList` as special processing is needed to convert a 'List' of
-- | 'Cookie's into a RFC-compliant Cookie header value string.
stringify' :: List Cookie -> String
stringify' = map stringify >>> intercalate ";"