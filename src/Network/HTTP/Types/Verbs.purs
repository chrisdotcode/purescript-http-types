module Network.HTTP.Types.Verbs
	( Verb
		( GET
		, HEAD
		, POST
		, PUT
		, DELETE
		, CONNECT
		, OPTIONS
		, TRACE
		, PATCH
		, Custom
		)
	, verbFromString
	) where

import Prelude ((==), class Eq, class Show, show)

-- | A list of common verbs. If it's non-common, use the 'Custom'
-- | constructor.
data Verb = GET
	  | HEAD
	  | POST
	  | PUT
	  | DELETE
	  | CONNECT
	  | OPTIONS
	  | TRACE
	  | PATCH
	  | Custom String

instance showVerb :: Show Verb where
	show GET        = "GET"
	show HEAD       = "HEAD"
	show POST       = "POST"
	show PUT        = "PUT"
	show DELETE     = "DELETE"
	show CONNECT    = "CONNECT"
	show OPTIONS    = "OPTIONS"
	show TRACE      = "TRACE"
	show PATCH      = "PATCH"
	show (Custom v) = v

instance eqVerb :: Eq Verb where
	eq v1 v2 = show v1 == show v2

-- | Creates a 'Verb' from a string. If the given string is a
-- | non-common HTTP verb, then a 'Custom' 'Verb' is returned.
--
-- All HTTP Verbs are case-sensitive.
verbFromString :: String -> Verb
verbFromString "GET"     = GET
verbFromString "HEAD"    = HEAD
verbFromString "POST"    = POST
verbFromString "PUT"     = PUT
verbFromString "DELETE"  = DELETE
verbFromString "CONNECT" = CONNECT
verbFromString "OPTIONS" = OPTIONS
verbFromString "TRACE"   = TRACE
verbFromString "PATCH"   = PATCH
verbFromString s         = Custom s
