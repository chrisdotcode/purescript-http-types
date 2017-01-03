## Module Network.HTTP.Types.Methods

#### `Method`

``` purescript
data Method
  = GET
  | HEAD
  | POST
  | PUT
  | DELETE
  | CONNECT
  | OPTIONS
  | TRACE
  | PATCH
  | Custom String
```

A list of common methods. If it's non-common, use the 'Custom'
constructor.

##### Instances
``` purescript
Show Method
Eq Method
```

#### `methodFromString`

``` purescript
methodFromString :: String -> Method
```

Creates a 'Method' from a string. If the given string is a
non-common HTTP method, then a 'Custom' 'Method' is returned.


