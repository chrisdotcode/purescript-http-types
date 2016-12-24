## Module Network.HTTP.Types.Verbs

#### `Verb`

``` purescript
data Verb
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

A list of common verbs. If it's non-common, use the 'Custom'
constructor.

##### Instances
``` purescript
Show Verb
Eq Verb
```

#### `verbFromString`

``` purescript
verbFromString :: String -> Verb
```

Creates a 'Verb' from a string. If the given string is a
non-common HTTP verb, then a 'Custom' 'Verb' is returned.


