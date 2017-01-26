module Network.HTTP.Types.StatusCode
	( ReasonPhrase
		( Continue
		, SwitchingProtocols
		, OK
		, Created
		, Accepted
		, NonAuthoritativeInformation
		, NoContent
		, ResetContent
		, PartialContent
		, MultipleChoices
		, MovedPermanently
		, Found
		, SeeOther
		, NotModified
		, UseProxy
		, TemporaryRedirect
		, BadRequest
		, Unauthorized
		, PaymentRequired
		, Forbidden
		, NotFound
		, MethodNotAllowed
		, NotAcceptable
		, ProxyAuthenticationRequired
		, RequestTimeout
		, Conflict
		, Gone
		, LengthRequired
		, PreconditionFailed
		, PayloadTooLarge
		, URITooLong
		, UnsupportedMediaType
		, RangeNotSatisfiable
		, ExpectationFailed
		, UpgradeRequired
		, InternalServerError
		, NotImplemented
		, BadGateway
		, ServiceUnavailable
		, GatewayTimeout
		, HTTPVersionNotSupported
		, Custom
		)
	, StatusCode(StatusCode)
	, status100
	, status101
	, status200
	, status201
	, status202
	, status203
	, status204
	, status205
	, status206
	, status300
	, status301
	, status302
	, status303
	, status304
	, status305
	, status307
	, status400
	, status401
	, status402
	, status403
	, status404
	, status405
	, status406
	, status407
	, status408
	, status409
	, status410
	, status411
	, status412
	, status413
	, status414
	, status415
	, status416
	, status417
	, status426
	, status500
	, status501
	, status502
	, status503
	, status504
	, status505
	, getRecognizedStatusCodeFromInt
	, reasonPhraseFromString
	, statusCodeFromString
	) where

import Prelude
	( (==)
	, (&&)
	, (<>)
	, class Eq
	, class Ord
	, class Show
	, compare
	, const
	, show
	)

import Data.Maybe  (Maybe(Just, Nothing))
import Data.String (toLower)

-- | A list of standard Reason Phrases that (usually) accompany a
-- | status code number. If it's non-standard, use the 'Custom'
-- | constructor.
data ReasonPhrase = Continue
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

instance showReasonPhrase :: Show ReasonPhrase where
	show Continue                    = "Continue"
	show SwitchingProtocols          = "Switching Protocols"
	show OK                          = "OK"
	show Created                     = "Created"
	show Accepted                    = "Accepted"
	show NonAuthoritativeInformation = "Non-Authoritative Information"
	show NoContent                   = "No Content"
	show ResetContent                = "Reset Content"
	show PartialContent              = "Partial Content"
	show MultipleChoices             = "Multiple Choices"
	show MovedPermanently            = "Moved Permanently"
	show Found                       = "Found"
	show SeeOther                    = "See Other"
	show NotModified                 = "Not Modified"
	show UseProxy                    = "Use Proxy"
	show TemporaryRedirect           = "Temporary Redirect"
	show BadRequest                  = "Bad Request"
	show Unauthorized                = "Unauthorized"
	show PaymentRequired             = "Payment Required"
	show Forbidden                   = "Forbidden"
	show NotFound                    = "Not Found"
	show MethodNotAllowed            = "Method Not Allowed"
	show NotAcceptable               = "Not Acceptable"
	show ProxyAuthenticationRequired = "Proxy Authentication Required"
	show RequestTimeout              = "Request Timeout"
	show Conflict                    = "Conflict"
	show Gone                        = "Gone"
	show LengthRequired              = "Length Required"
	show PreconditionFailed          = "Precondition Failed"
	show PayloadTooLarge             = "Payload Too Large"
	show URITooLong                  = "URI Too Long"
	show UnsupportedMediaType        = "Unsupported Media Type"
	show RangeNotSatisfiable         = "Range Not Satisfiable"
	show ExpectationFailed           = "Expectation Failed"
	show UpgradeRequired             = "Upgrade Required"
	show InternalServerError         = "Internal Service Error"
	show NotImplemented              = "Not Implemented"
	show BadGateway                  = "Bad Gateway"
	show ServiceUnavailable          = "Service Unavailable"
	show GatewayTimeout              = "Gateway Timeout"
	show HTTPVersionNotSupported     = "HTTP Version Not Supported"
	show (Custom r)                  = r

-- | Creates a 'ReasonPhrase' from a string. If the given string is a
-- | non-standard HTTP Reason Phrase, then a 'Custom' 'ReasonPhrase'
-- | is returned.
--
-- In RFC 2616 section 6.1.1, the Reason Phrases seem to be
-- case-sensitive, but we're a bit more liberal about that here by
-- accepting mixed-cased messages.
reasonPhraseFromString :: String -> ReasonPhrase
reasonPhraseFromString s = reasonPhraseFromString' (toLower s)
	where
		reasonPhraseFromString' "continue"                      = Continue
		reasonPhraseFromString' "switching protocols"           = SwitchingProtocols
		reasonPhraseFromString' "ok"                            = OK
		reasonPhraseFromString' "created"                       = Created
		reasonPhraseFromString' "accepted"                      = Accepted
		reasonPhraseFromString' "non-authoritative information" = NonAuthoritativeInformation
		reasonPhraseFromString' "no content"                    = NoContent
		reasonPhraseFromString' "reset content"                 = ResetContent
		reasonPhraseFromString' "partial content"               = PartialContent
		reasonPhraseFromString' "multiple choices"              = MultipleChoices
		reasonPhraseFromString' "moved permanently"             = MovedPermanently
		reasonPhraseFromString' "found"                         = Found
		reasonPhraseFromString' "see other"                     = SeeOther
		reasonPhraseFromString' "not modified"                  = NotModified
		reasonPhraseFromString' "use proxy"                     = UseProxy
		reasonPhraseFromString' "temporary redirect"            = TemporaryRedirect
		reasonPhraseFromString' "bad request"                   = BadRequest
		reasonPhraseFromString' "unauthorized"                  = Unauthorized
		reasonPhraseFromString' "payment required"              = PaymentRequired
		reasonPhraseFromString' "forbidden"                     = Forbidden
		reasonPhraseFromString' "not found"                     = NotFound
		reasonPhraseFromString' "method not allowed"            = MethodNotAllowed
		reasonPhraseFromString' "not acceptable"                = NotAcceptable
		reasonPhraseFromString' "proxy authentication required" = ProxyAuthenticationRequired
		reasonPhraseFromString' "request timeout"               = RequestTimeout
		reasonPhraseFromString' "conflict"                      = Conflict
		reasonPhraseFromString' "gone"                          = Gone
		reasonPhraseFromString' "length required"               = LengthRequired
		reasonPhraseFromString' "precondition failed"           = PreconditionFailed
		reasonPhraseFromString' "payload too large"             = PayloadTooLarge
		reasonPhraseFromString' "uri too long"                  = URITooLong
		reasonPhraseFromString' "unsupported media type"        = UnsupportedMediaType
		reasonPhraseFromString' "range not satisfiable"         = RangeNotSatisfiable
		reasonPhraseFromString' "expectation failed"            = ExpectationFailed
		reasonPhraseFromString' "upgrade required"              = UpgradeRequired
		reasonPhraseFromString' "internal server error"        = InternalServerError
		reasonPhraseFromString' "not implemented"               = NotImplemented
		reasonPhraseFromString' "bad gateway"                   = BadGateway
		reasonPhraseFromString' "service unavailable"           = ServiceUnavailable
		reasonPhraseFromString' "gateway timeout"               = GatewayTimeout
		reasonPhraseFromString' "http version not supported"    = HTTPVersionNotSupported
		reasonPhraseFromString' _                               = Custom s

instance eqReasonPhrase :: Eq ReasonPhrase where
	eq r1 r2 = show r1 == show r2

-- | A type that represents an HTTP StatusCode. Consists of both it's
-- | code (e.g.: '400'), and it's Reason Phrase (e.g.: 'Bad Request').
--
-- This type should maybe actually be called Status-Line, but it's
-- more practical to just call it StatusCode, and group the Reason
-- Phrase with the status code.
newtype StatusCode = StatusCode
	{ code         :: Int
	, reasonPhrase :: ReasonPhrase
	}

instance showStatusCode :: Show StatusCode where
	show (StatusCode { code, reasonPhrase }) = show code
		<> " " <> show reasonPhrase

instance eqStatusCode :: Eq StatusCode where
	eq (StatusCode s1) (StatusCode s2) = s1.code == s2.code
		&& s1.reasonPhrase == s2.reasonPhrase

instance ordStatusCode :: Ord StatusCode where
	compare (StatusCode { code: c1 }) (StatusCode { code: c2 }) =
		compare c1 c2

setCode :: Int -> StatusCode -> StatusCode
setCode code (StatusCode s) = StatusCode s { code = code }

setResponsePhrase :: ReasonPhrase -> StatusCode -> StatusCode
setResponsePhrase reasonPhrase (StatusCode s) =
	StatusCode s { reasonPhrase = reasonPhrase }

status100 :: StatusCode
status100 = StatusCode
	{ code        : 100
	, reasonPhrase: Continue
	}

status101 :: StatusCode
status101 = StatusCode
	{ code        : 101
	, reasonPhrase: SwitchingProtocols
	}

status200 :: StatusCode
status200 = StatusCode
	{ code        : 200
	, reasonPhrase: OK
	}

status201 :: StatusCode
status201 = StatusCode
	{ code        : 201
	, reasonPhrase: Created
	}

status202 :: StatusCode
status202 = StatusCode
	{ code        : 202
	, reasonPhrase: Accepted
	}

status203 :: StatusCode
status203 = StatusCode
	{ code        : 203
	, reasonPhrase: NonAuthoritativeInformation
	}

status204 :: StatusCode
status204 = StatusCode
	{ code        : 204
	, reasonPhrase: NoContent
	}

status205 :: StatusCode
status205 = StatusCode
	{ code        : 205
	, reasonPhrase: ResetContent
	}

status206 :: StatusCode
status206 = StatusCode
	{ code        : 206
	, reasonPhrase: PartialContent
	}

status300 :: StatusCode
status300 = StatusCode
	{ code        : 300
	, reasonPhrase: MultipleChoices
	}

status301 :: StatusCode
status301 = StatusCode
	{ code        : 301
	, reasonPhrase: MovedPermanently
	}

status302 :: StatusCode
status302 = StatusCode
	{ code        : 302
	, reasonPhrase: Found
	}

status303 :: StatusCode
status303 = StatusCode
	{ code        : 303
	, reasonPhrase: SeeOther
	}

status304 :: StatusCode
status304 = StatusCode
	{ code        : 304
	, reasonPhrase: NotModified
	}

status305 :: StatusCode
status305 = StatusCode
	{ code        : 305
	, reasonPhrase: UseProxy
	}

status307 :: StatusCode
status307 = StatusCode
	{ code        : 307
	, reasonPhrase: TemporaryRedirect
	}

status400 :: StatusCode
status400 = StatusCode
	{ code        : 400
	, reasonPhrase: BadRequest
	}

status401 :: StatusCode
status401 = StatusCode
	{ code        : 401
	, reasonPhrase: Unauthorized
	}

status402 :: StatusCode
status402 = StatusCode
	{ code        : 402
	, reasonPhrase: PaymentRequired
	}

status403 :: StatusCode
status403 = StatusCode
	{ code        : 403
	, reasonPhrase: Forbidden
	}

status404 :: StatusCode
status404 = StatusCode
	{ code        : 404
	, reasonPhrase: NotFound
	}

status405 :: StatusCode
status405 = StatusCode
	{ code        : 405
	, reasonPhrase: MethodNotAllowed
	}

status406 :: StatusCode
status406 = StatusCode
	{ code        : 406
	, reasonPhrase: NotAcceptable
	}

status407 :: StatusCode
status407 = StatusCode
	{ code        : 407
	, reasonPhrase: ProxyAuthenticationRequired
	}

status408 :: StatusCode
status408 = StatusCode
	{ code        : 408
	, reasonPhrase: RequestTimeout
	}

status409 :: StatusCode
status409 = StatusCode
	{ code        : 409
	, reasonPhrase: Conflict
	}

status410 :: StatusCode
status410 = StatusCode
	{ code        : 410
	, reasonPhrase: Gone
	}

status411 :: StatusCode
status411 = StatusCode
	{ code        : 411
	, reasonPhrase: LengthRequired
	}

status412 :: StatusCode
status412 = StatusCode
	{ code        : 412
	, reasonPhrase: PreconditionFailed
	}

status413 :: StatusCode
status413 = StatusCode
	{ code        : 413
	, reasonPhrase: PayloadTooLarge
	}

status414 :: StatusCode
status414 = StatusCode
	{ code        : 414
	, reasonPhrase: URITooLong
	}

status415 :: StatusCode
status415 = StatusCode
	{ code        : 415
	, reasonPhrase: UnsupportedMediaType
	}

status416 :: StatusCode
status416 = StatusCode
	{ code        : 416
	, reasonPhrase: RangeNotSatisfiable
	}

status417 :: StatusCode
status417 = StatusCode
	{ code        : 417
	, reasonPhrase: ExpectationFailed
	}

status426 :: StatusCode
status426 = StatusCode
	{ code        : 426
	, reasonPhrase: UpgradeRequired
	}

status500 :: StatusCode
status500 = StatusCode
	{ code        : 500
	, reasonPhrase: InternalServerError
	}

status501 :: StatusCode
status501 = StatusCode
	{ code        : 501
	, reasonPhrase: NotImplemented
	}

status502 :: StatusCode
status502 = StatusCode
	{ code        : 502
	, reasonPhrase: BadGateway
	}

status503 :: StatusCode
status503 = StatusCode
	{ code        : 503
	, reasonPhrase: ServiceUnavailable
	}

status504 :: StatusCode
status504 = StatusCode
	{ code        : 504
	, reasonPhrase: GatewayTimeout
	}

status505 :: StatusCode
status505 = StatusCode
	{ code        : 505
	, reasonPhrase: HTTPVersionNotSupported
	}

-- | Returns a standard 'StatusCode' if the given integer correlates
-- | to a standard status code number. Returns 'Nothing' otherwise.
getRecognizedStatusCodeFromInt :: Int -> Maybe StatusCode
getRecognizedStatusCodeFromInt 100 = Just status100
getRecognizedStatusCodeFromInt 101 = Just status101
getRecognizedStatusCodeFromInt 200 = Just status200
getRecognizedStatusCodeFromInt 201 = Just status201
getRecognizedStatusCodeFromInt 202 = Just status202
getRecognizedStatusCodeFromInt 203 = Just status203
getRecognizedStatusCodeFromInt 204 = Just status204
getRecognizedStatusCodeFromInt 205 = Just status205
getRecognizedStatusCodeFromInt 206 = Just status206
getRecognizedStatusCodeFromInt 300 = Just status300
getRecognizedStatusCodeFromInt 301 = Just status301
getRecognizedStatusCodeFromInt 302 = Just status302
getRecognizedStatusCodeFromInt 303 = Just status303
getRecognizedStatusCodeFromInt 304 = Just status304
getRecognizedStatusCodeFromInt 305 = Just status305
getRecognizedStatusCodeFromInt 307 = Just status307
getRecognizedStatusCodeFromInt 400 = Just status400
getRecognizedStatusCodeFromInt 401 = Just status401
getRecognizedStatusCodeFromInt 402 = Just status402
getRecognizedStatusCodeFromInt 403 = Just status403
getRecognizedStatusCodeFromInt 404 = Just status404
getRecognizedStatusCodeFromInt 405 = Just status405
getRecognizedStatusCodeFromInt 406 = Just status406
getRecognizedStatusCodeFromInt 407 = Just status407
getRecognizedStatusCodeFromInt 408 = Just status408
getRecognizedStatusCodeFromInt 409 = Just status409
getRecognizedStatusCodeFromInt 410 = Just status410
getRecognizedStatusCodeFromInt 411 = Just status411
getRecognizedStatusCodeFromInt 412 = Just status412
getRecognizedStatusCodeFromInt 413 = Just status413
getRecognizedStatusCodeFromInt 414 = Just status414
getRecognizedStatusCodeFromInt 415 = Just status415
getRecognizedStatusCodeFromInt 416 = Just status416
getRecognizedStatusCodeFromInt 417 = Just status417
getRecognizedStatusCodeFromInt 426 = Just status426
getRecognizedStatusCodeFromInt 500 = Just status500
getRecognizedStatusCodeFromInt 501 = Just status501
getRecognizedStatusCodeFromInt 502 = Just status502
getRecognizedStatusCodeFromInt 503 = Just status503
getRecognizedStatusCodeFromInt 504 = Just status504
getRecognizedStatusCodeFromInt 505 = Just status505
getRecognizedStatusCodeFromInt _   = Nothing

foreign import statusCodeFromStringImpl :: (StatusCode -> Maybe StatusCode)                              -> -- Just constructor
					   (StatusCode -> Maybe StatusCode)                              -> -- Nothing constructor
					   ({ code :: Int, reasonPhrase :: ReasonPhrase } -> StatusCode) -> -- StatusCode constructor
					   (String -> ReasonPhrase)                                      -> -- reasonPhraseFromString
					   String                                                        ->
					   Maybe StatusCode

-- | Returns a 'StatusCode' if the given string can be coerced into
-- | one. The expected string format is `Status-Code SP Reason-Phrase`
-- | (e.g.: `'400 Bad Request'`) (from RFC 2616, section 6.1).
--
-- XXX I should replace this with a pure PureScript impl.
statusCodeFromString :: String -> Maybe StatusCode
statusCodeFromString = statusCodeFromStringImpl Just (const Nothing) StatusCode reasonPhraseFromString
