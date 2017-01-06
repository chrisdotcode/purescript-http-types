module Network.HTTP.Types.Headers
	( HeaderName
		( AIM
		, Accept
		, AcceptAdditions
		, AcceptCharset
		, AcceptEncoding
		, AcceptFeatures
		, AcceptLanguage
		, AcceptRanges
		, Age
		, Allow
		, Alternates
		, AuthenticationInfo
		, Authorization
		, CExt
		, CMan
		, COpt
		, CPEP
		, CPEPInfo
		, CacheControl
		, Connection
		, ContentBase
		, ContentDisposition
		, ContentEncoding
		, ContentID
		, ContentLanguage
		, ContentLength
		, ContentLocation
		, ContentMD5
		, ContentRange
		, ContentScriptType
		, ContentStyleType
		, ContentType
		, ContentVersion
		, Cookie
		, Cookie2
		, DAV
		, Date
		, DefaultStyle
		, DeltaBase
		, Depth
		, DerivedFrom
		, Destination
		, DifferentialID
		, Digest
		, ETag
		, Expect
		, Expires
		, Ext
		, From
		, GetProfile
		, Host
		, IM
		, If
		, IfMatch
		, IfModifiedSince
		, IfNoneMatch
		, IfRange
		, IfUnmodifiedSince
		, KeepAlive
		, Label
		, LastModified
		, Link
		, Location
		, LockToken
		, MIMEVersion
		, Man
		, MaxForwards
		, Meter
		, Negotiate
		, Opt
		, OrderingType
		, Overwrite
		, P3P
		, PEP
		, PICSLabel
		, PepInfo
		, Position
		, Pragma
		, ProfileObject
		, Protocol
		, ProtocolInfo
		, ProtocolQuery
		, ProtocolRequest
		, ProxyAuthenticate
		, ProxyAuthenticationInfo
		, ProxyAuthorization
		, ProxyFeatures
		, ProxyInstruction
		, Public
		, Range
		, Referer
		, RetryAfter
		, Safe
		, SecurityScheme
		, Server
		, SetCookie
		, SetCookie2
		, SetProfile
		, SoapAction
		, StatusURI
		, SurrogateCapability
		, SurrogateControl
		, TCN
		, TE
		, Timeout
		, Trailer
		, TransferEncoding
		, URI
		, Upgrade
		, UserAgent
		, VariantVary
		, Vary
		, Via
		, WWWAuthenticate
		, WantDigest
		, Warning
		, Custom
		)
	, Headers
	, headerNameFromString
	) where

import Prelude
	( (==)
	, class Eq
	, class Ord
	, class Show
	, compare
	, show
	)

import Data.Map           (Map)
import Data.String        (toLower)

-- | A list of standard headers. If it's non-standard, use the
-- | 'Custom' constructor.
data HeaderName = AIM
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

instance showHeaderName :: Show HeaderName where
	show AIM                     = "A-IM"
	show Accept                  = "Accept"
	show AcceptAdditions         = "Accept-Additions"
	show AcceptCharset           = "Accept-Charset"
	show AcceptEncoding          = "Accept-Encoding"
	show AcceptFeatures          = "Accept-Features"
	show AcceptLanguage          = "Accept-Language"
	show AcceptRanges            = "Accept-Ranges"
	show Age                     = "Age"
	show Allow                   = "Allow"
	show Alternates              = "Alternates"
	show AuthenticationInfo      = "Authentication-Info"
	show Authorization           = "Authorization"
	show CExt                    = "C-Ext"
	show CMan                    = "C-Man"
	show COpt                    = "C-Opt"
	show CPEP                    = "C-PEP"
	show CPEPInfo                = "C-PEP-Info"
	show CacheControl            = "Cache-Control"
	show Connection              = "Connection"
	show ContentBase             = "Content-Base"
	show ContentDisposition      = "Content-Disposition"
	show ContentEncoding         = "Content-Encoding"
	show ContentID               = "Content-ID"
	show ContentLanguage         = "Content-Language"
	show ContentLength           = "Content-Length"
	show ContentLocation         = "Content-Location"
	show ContentMD5              = "Content-MD5"
	show ContentRange            = "Content-Range"
	show ContentScriptType       = "Content-Script-Type"
	show ContentStyleType        = "Content-Style-Type"
	show ContentType             = "Content-Type"
	show ContentVersion          = "Content-Version"
	show Cookie                  = "Cookie"
	show Cookie2                 = "Cookie2"
	show DAV                     = "DAV"
	show Date                    = "Date"
	show DefaultStyle            = "Default-Style"
	show DeltaBase               = "Delta-Base"
	show Depth                   = "Depth"
	show DerivedFrom             = "Derived-From"
	show Destination             = "Destination"
	show DifferentialID          = "Differential-ID"
	show Digest                  = "Digest"
	show ETag                    = "ETag"
	show Expect                  = "Expect"
	show Expires                 = "Expires"
	show Ext                     = "Ext"
	show From                    = "From"
	show GetProfile              = "GetProfile"
	show Host                    = "Host"
	show IM                      = "IM"
	show If                      = "If"
	show IfMatch                 = "If-Match"
	show IfModifiedSince         = "If-Modified-Since"
	show IfNoneMatch             = "If-None-Match"
	show IfRange                 = "If-Range"
	show IfUnmodifiedSince       = "If-Unmodified-Since"
	show KeepAlive               = "Keep-Alive"
	show Label                   = "Label"
	show LastModified            = "Last-Modified"
	show Link                    = "Link"
	show Location                = "Location"
	show LockToken               = "Lock-Token"
	show MIMEVersion             = "MIME-Version"
	show Man                     = "Man"
	show MaxForwards             = "Max-Forwards"
	show Meter                   = "Meter"
	show Negotiate               = "Negotiate"
	show Opt                     = "Opt"
	show OrderingType            = "Ordering-Type"
	show Overwrite               = "Overwrite"
	show P3P                     = "P3P"
	show PEP                     = "PEP"
	show PICSLabel               = "PICS-Label"
	show PepInfo                 = "Pep-Info"
	show Position                = "Position"
	show Pragma                  = "Pragma"
	show ProfileObject           = "ProfileObject"
	show Protocol                = "Protocol"
	show ProtocolInfo            = "Protocol-Info"
	show ProtocolQuery           = "Protocol-Query"
	show ProtocolRequest         = "Protocol-Request"
	show ProxyAuthenticate       = "Proxy-Authenticate"
	show ProxyAuthenticationInfo = "Proxy-Authentication-Info"
	show ProxyAuthorization      = "Proxy-Authorization"
	show ProxyFeatures           = "Proxy-Features"
	show ProxyInstruction        = "Proxy-Instruction"
	show Public                  = "Public"
	show Range                   = "Range"
	show Referer                 = "Referer"
	show RetryAfter              = "Retry-After"
	show Safe                    = "Safe"
	show SecurityScheme          = "Security-Scheme"
	show Server                  = "Server"
	show SetCookie               = "Set-Cookie"
	show SetCookie2              = "Set-Cookie2"
	show SetProfile              = "SetProfile"
	show SoapAction              = "SoapAction"
	show StatusURI               = "Status-URI"
	show SurrogateCapability     = "Surrogate-Capability"
	show SurrogateControl        = "Surrogate-Control"
	show TCN                     = "TCN"
	show TE                      = "TE"
	show Timeout                 = "Timeout"
	show Trailer                 = "Trailer"
	show TransferEncoding        = "Transfer-Encoding"
	show URI                     = "URI"
	show Upgrade                 = "Upgrade"
	show UserAgent               = "User-Agent"
	show VariantVary             = "Variant-Vary"
	show Vary                    = "Vary"
	show Via                     = "Via"
	show WWWAuthenticate         = "WWW-Authenticate"
	show WantDigest              = "Want-Digest"
	show Warning                 = "Warning"
	show (Custom h)              = h

instance eqHeaderName :: Eq HeaderName where
	eq h1 h2 = show h1 == show h2

instance ordHeaderName :: Ord HeaderName where
	compare h1 h2 = compare (show h1) (show h2)

-- | Creates a 'HeaderName' from a string. If the given string is a
-- | non-standard HTTP header name, then a 'Custom' 'HeaderName' is
-- | returned.
headerNameFromString :: String -> HeaderName
headerNameFromString s = headerNameFromString' (toLower s)
	where
		headerNameFromString' "a-im"                      = AIM
		headerNameFromString' "accept"                    = Accept                  
		headerNameFromString' "accept-additions"          = AcceptAdditions         
		headerNameFromString' "accept-charset"            = AcceptCharset           
		headerNameFromString' "accept-encoding"           = AcceptEncoding 
		headerNameFromString' "accept-features"           = AcceptFeatures          
		headerNameFromString' "accept-language"           = AcceptLanguage
		headerNameFromString' "accept-ranges"             = AcceptRanges
		headerNameFromString' "age"                       = Age
		headerNameFromString' "allow"                     = Allow
		headerNameFromString' "alternates"                = Alternates
		headerNameFromString' "authentication-info"       = AuthenticationInfo
		headerNameFromString' "authorization"             = Authorization
		headerNameFromString' "c-ext"                     = CExt
		headerNameFromString' "c-man"                     = CMan
		headerNameFromString' "c-opt"                     = COpt
		headerNameFromString' "c-pep"                     = CPEP
		headerNameFromString' "c-pep-info"                = CPEPInfo
		headerNameFromString' "cache-control"             = CacheControl
		headerNameFromString' "connection"                = Connection
		headerNameFromString' "content-base"              = ContentBase
		headerNameFromString' "content-disposition"       = ContentDisposition
		headerNameFromString' "content-encoding"          = ContentEncoding
		headerNameFromString' "content-id"                = ContentID
		headerNameFromString' "content-language"          = ContentLanguage
		headerNameFromString' "content-length"            = ContentLength
		headerNameFromString' "content-location"          = ContentLocation
		headerNameFromString' "content-md5"               = ContentMD5
		headerNameFromString' "content-range"             = ContentRange
		headerNameFromString' "content-script-type"       = ContentScriptType
		headerNameFromString' "content-style-type"        = ContentStyleType
		headerNameFromString' "content-type"              = ContentType
		headerNameFromString' "content-version"           = ContentVersion
		headerNameFromString' "cookie"                    = Cookie
		headerNameFromString' "cookie2"                   = Cookie2
		headerNameFromString' "dav"                       = DAV
		headerNameFromString' "date"                      = Date
		headerNameFromString' "default-style"             = DefaultStyle
		headerNameFromString' "delta-base"                = DeltaBase
		headerNameFromString' "depth"                     = Depth
		headerNameFromString' "derived-from"              = DerivedFrom
		headerNameFromString' "destination"               = Destination
		headerNameFromString' "differential-id"           = DifferentialID
		headerNameFromString' "digest"                    = Digest
		headerNameFromString' "etag"                      = ETag
		headerNameFromString' "expect"                    = Expect
		headerNameFromString' "expires"                   = Expires
		headerNameFromString' "ext"                       = Ext
		headerNameFromString' "from"                      = From
		headerNameFromString' "getprofile"                = GetProfile
		headerNameFromString' "host"                      = Host
		headerNameFromString' "im"                        = IM
		headerNameFromString' "if"                        = If
		headerNameFromString' "if-match"                  = IfMatch
		headerNameFromString' "if-modified-since"         = IfModifiedSince
		headerNameFromString' "if-none-match"             = IfNoneMatch
		headerNameFromString' "if-range"                  = IfRange
		headerNameFromString' "if-unmodified-since"       = IfUnmodifiedSince
		headerNameFromString' "keep-alive"                = KeepAlive
		headerNameFromString' "label"                     = Label
		headerNameFromString' "last-modified"             = LastModified
		headerNameFromString' "link"                      = Link
		headerNameFromString' "location"                  = Location
		headerNameFromString' "lock-token"                = LockToken
		headerNameFromString' "mime-version"              = MIMEVersion
		headerNameFromString' "man"                       = Man
		headerNameFromString' "max-forwards"              = MaxForwards
		headerNameFromString' "meter"                     = Meter
		headerNameFromString' "negotiate"                 = Negotiate
		headerNameFromString' "opt"                       = Opt
		headerNameFromString' "ordering-type"             = OrderingType
		headerNameFromString' "overwrite"                 = Overwrite
		headerNameFromString' "p3p"                       = P3P
		headerNameFromString' "pep"                       = PEP
		headerNameFromString' "pics-label"                = PICSLabel
		headerNameFromString' "pep-info"                  = PepInfo
		headerNameFromString' "position"                  = Position
		headerNameFromString' "pragma"                    = Pragma
		headerNameFromString' "profileobject"             = ProfileObject
		headerNameFromString' "protocol"                  = Protocol
		headerNameFromString' "protocol-info"             = ProtocolInfo
		headerNameFromString' "protocol-query"            = ProtocolQuery
		headerNameFromString' "protocol-request"          = ProtocolRequest
		headerNameFromString' "proxy-authenticate"        = ProxyAuthenticate
		headerNameFromString' "proxy-authentication-info" = ProxyAuthenticationInfo
		headerNameFromString' "proxy-authorization"       = ProxyAuthorization
		headerNameFromString' "proxy-features"            = ProxyFeatures
		headerNameFromString' "proxy-instruction"         = ProxyInstruction
		headerNameFromString' "public"                    = Public
		headerNameFromString' "range"                     = Range
		headerNameFromString' "referer"                   = Referer
		headerNameFromString' "retry-after"               = RetryAfter
		headerNameFromString' "safe"                      = Safe
		headerNameFromString' "security-scheme"           = SecurityScheme
		headerNameFromString' "server"                    = Server
		headerNameFromString' "set-cookie"                = SetCookie
		headerNameFromString' "set-cookie2"               = SetCookie2
		headerNameFromString' "setprofile"                = SetProfile
		headerNameFromString' "soapaction"                = SoapAction
		headerNameFromString' "status-uri"                = StatusURI
		headerNameFromString' "surrogate-capability"      = SurrogateCapability
		headerNameFromString' "surrogate-control"         = SurrogateControl
		headerNameFromString' "tcn"                       = TCN
		headerNameFromString' "te"                        = TE
		headerNameFromString' "timeout"                   = Timeout
		headerNameFromString' "trailer"                   = Trailer
		headerNameFromString' "transfer-encoding"         = TransferEncoding
		headerNameFromString' "uri"                       = URI
		headerNameFromString' "upgrade"                   = Upgrade
		headerNameFromString' "user-agent"                = UserAgent
		headerNameFromString' "variant-vary"              = VariantVary
		headerNameFromString' "vary"                      = Vary
		headerNameFromString' "via"                       = Via
		headerNameFromString' "www-authenticate"          = WWWAuthenticate
		headerNameFromString' "want-digest"               = WantDigest
		headerNameFromString' "warning"                   = Warning
		headerNameFromString' _                           = Custom s

-- | A type alias for a group of HTTP headers.
type Headers = Map HeaderName String
