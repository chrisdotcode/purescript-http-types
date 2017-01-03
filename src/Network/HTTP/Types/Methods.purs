module Network.HTTP.Types.Methods
	( Method
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
	, methodFromString
	) where

import Prelude ((==), class Eq, class Show, show)

-- | A list of common methods. If it's non-common, use the 'Custom'
-- | constructor.
data Method = GET
	    | HEAD
	    | POST
	    | PUT
	    | DELETE
	    | CONNECT
	    | OPTIONS
	    | TRACE
	    | PATCH
	    | Custom String

instance showMethod :: Show Method where
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

instance eqMethod :: Eq Method where
	eq v1 v2 = show v1 == show v2

-- | Creates a 'Method' from a string. If the given string is a
-- | non-common HTTP method, then a 'Custom' 'Method' is returned.
--
-- All HTTP Methods are case-sensitive.
methodFromString :: String -> Method
methodFromString "GET"     = GET
methodFromString "HEAD"    = HEAD
methodFromString "POST"    = POST
methodFromString "PUT"     = PUT
methodFromString "DELETE"  = DELETE
methodFromString "CONNECT" = CONNECT
methodFromString "OPTIONS" = OPTIONS
methodFromString "TRACE"   = TRACE
methodFromString "PATCH"   = PATCH
methodFromString s         = Custom s
