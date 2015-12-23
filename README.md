# Shapely
[![Build Status](https://secure.travis-ci.org/AriaMinaei/shapely.svg?branch=master)](https://travis-ci.org/AriaMinaei/shapely)

A runtime type checker for javascript with support for records and tagged unions.

## Use cases

Shapely is useful in projects where:
* You *can't* use static type checkers.
* You *can* use static type checkers, but you still need to validate the shape of data in runtime to make sure that they adhere to a certain protocol, forexample in client/server communication (unless you're using GraphQL).

## Example

Here we have a simple client/server setup:
* The server implements three functions: `getCartItems`, `getItemById`, and `addItemToCart`, and they are written by different team members.
* Each of these functions is expected to:
  - Return `{kind: 'Success', payload: any}` when invoked successfully.
  - Return `{kind: 'Failure', message: String}` when invoked unsuccessfully.
* We need to validate that each function actually follows this protocol every time it's invoked. We'll validate that both on the server and on the client.

```javascript
// ServerResponse.js

// This file defines the server's resopnse protocol,
// and it'll be used both by the server and the client.

import {record, union, any} from 'shapely';

// This is basically a tagged union that defines the two
// possible shapes of the server's response data. The equivalent
// flow type would look like this:
// type ServerResponse =
//    {kind: 'Success', payload: mixed} |
//    {kind: 'Failure', message: string}
export const ServerResponse = union(
  record({
    kind: 'Success',
    payload: any
  }),
  record({
    kind: 'Failure',
    message: String
  })
);
```

```javascript
// server.js

// The server imports the three functions, listens for requests from the client,
// routes each request to the correct function, and then validates the returned value
// of that function before sending it to the client.

import {ServerResponse} from './ServerResponse';
import {isValid} from 'shapely';

import {getCartItems} from './fns/getCartItems';
import {getItemById} from './fns/getItemById';
import {addItemToCart} from './fns/addItemToCart';
const fns = {getCartItems, getItemById, addItemToCart};

onRequest((fnName, args, respond) => {
  var responsePromise;
  if (fns[fnName]) {
    responsePromise = fns[fnName](args);
  } else {
    responsePromise = Promise.reject({
      kind: 'Failure',
      message: `Unkown function ${fnName}`
    });
  }

  function handleResponse(responseData) {
    if (isValid(ServerResponse, responseData)) {
      respond(responseData);
    } else {
      respond({kind: 'Failure', message: 'Internal server error'});
    }
  };

  return responsePromise.then(handleResponse, handleResponse);
});
```

```javascript
// client.js

// The client simply sends requests to the server,
// and returns a promise that either fulfills or rejects,
// based on the server's response.

import {isValid} from 'shapely';
import {ServerResponse} from './ServerResponse';

export function request(fnName, args) {
  return callServer(fnName, args)
  .then((response) => {
    if (!isValid(ServerResponse, response)) {
      return Promise.reject('Invalid server response');
    }

    if (response.kind === 'Success') {
      return response.payload;
    } else {
      return Promise.reject(response);
    }
  });
};
```

## Usage

With shapely, you first define a validator, and then you verify the shape of some value using that validator.

### validate()

Takes a validator and a value:
* If valid, **returns** the same value.
* If invalid, **throws**.

Example:
```javascript
import {validate} from 'shapely';

// Here, String is automatically recognized as a validator
validate(String, 'a'); // returns 'a', since 'a' is a String
validate(String, 10); // throws, since 10 is not a String
```

### isValid()

Takes a validator and a value. Returns true/false.

Example:
```javascript
import {isValid} from 'shapely';

isValid(String, 'a'); // returns true
isValid(String, 10); // returns false
```

### Strings, Numbers, Booleans

These three are automatically recognized as validators

```javascript
import {isValid} from 'shapely';

isValid(String, 'a'); // returns true
isValid(Number, 10); // returns true
isValid(Boolean, false) // returns true
```

### Matching any value
```javascript
import {isValid, any} from 'shapely';

isValid(any, ...); // returns true for any value, including null
```

### Unions

A Union is just a collection of other validators:
```javascript
import {isValid, union} from 'shapely';

const StringOrNumber = union(String, Number);

isValid(StringOrNumber, 'a'); // returns true
isValid(StringOrNumber, 10); // returns true
isValid(StringOrNumber, {}); // returns false
```

### Records

Records check if an object has certain keys and whether those keys match their respective validators:
```javascript
import {isValid, record} from 'shapely';

const LaunchVehicle = record({
  model: String,
  year: Number
});

isValid(LaunchVehicle, {model: 'Falcon 9', year: 2010}); // returns true
isValid(LaunchVehicle, {model: 'Falcon 9', year: 2010, extras: 'whatever'}); // returns true, since only the expected keys are checked
isValid(LaunchVehicle, {model: 'Falcon 9', year: 'some string'}); // returns false
```

### Equality

Strings and numbers can be used as validators to check if a value is strictly equal to them. We'll use this later to construct tagged unions.

```javascript
import {isValid} from 'shapely';

isValid('a', 'a'); // returns true since they are equal
isValid('a', 'b'); // returns false
isValid(10, 10); // returns true
isValid(10, 11); // returns false

// note that like all other validators, we can use `validate()`
// instead of `isValid()` to get a nice error:
validate('a', 'b'); // throws Error Expected 'b' to equal 'a'
```

### Tagged Unions

Tagged unions are just unions of records:

```javascript
import {union, record, any} from 'shapely';

const Response = union(
  record({
    kind: 'Success', // we're using strict equality here
    payload: any
  }),

  record({
    kind: 'Failure',
    message: String
  })
);

isValid(Response, {kind: 'Success', payload: 10}); // returns true
isValid(Response, {kind: 'Failure', message: 'Bad args'}); // returns true
isValid(Response, {kind: 'Failure'}); // returns false
```

### Arrays
```javascript
import {arrayOf, union, isValid} from 'shapely';

const ArrayOfNumbersOrStrings = arrayOf(union(Number, String));

isValid(ArrayOfNumbersOrStrings, [10, 11, 12]); // returns true
isValid(ArrayOfNumbersOrStrings, ['a', 'b', 'c']); // returns true
isValid(ArrayOfNumbersOrStrings, ['a', 'b', 12]); // returns true
isValid(ArrayOfNumbersOrStrings, [10, 11, {}]); // returns false
```

### Maps
```javascript
import {mapOf, isValid} from 'shapely';

const MapOfBooleans = mapOf(Boolean);

isValid(MapOfBooleans, {a: true, b: false}); // returns true
isValid(MapOfBooleans, {a: true, b: 'a'}); // returns false
```

### Optional values
```javascript
import {record, optional} from 'shapely';

const LaunchVehicle = record({
  name: String,
  year: Number,
  firstLaunchYear: optional(Number)
});

isValid(
  LaunchVehicle,
  {name: 'Falcon 9', year: 2010, firstLaunchYear: 2010}
  ); // returns true

isValid(
  LaunchVehicle,
  {name: 'Falcon 5', year: 2002}
  ); // returns true
```

### Nil
```javascript
import {isValid, nil} from 'shapely';

isValid(nil, null); // returns true
isValid(nil, undefined); // returns true
isValid(nil, 'a'); // returns false
```

### Deferred validators and Recursive structures

If validator `A` requires validator `B`, but `B` is not yet defined at the time `A` is being defined, you can use `deferred()` to defer the resolution of `B` to a later time:
```javascript
import {deferred, record} from 'shapely';

const Human = record({
  name: deferred(=> HumanName), // HumanName is not defined at the moment
  age: Number
});

const HumanName = String;

isValid(Human, {name: 'Anish', age: 50}); // returns true
```

We can use `deferred()` to construct recursive types too:

```javascript
import {record, union, deferred, nil, any} from 'shapely';

// This is the shape of a BinaryTree. The equivalent flow type would look
// like this:
// type BinaryTree = null | {val: mixed, left: BinaryTree, right: BinaryTree}
const BinaryTree = union(
  nil,
  record({
    val: any,
    left: deferred(=> BinaryTree), // we use deferred() because at this line, BinaryTree is not defined yet.
    right: deferred(=> BinaryTree),
  })
);

isValid(
  BinaryTree,
  {
    val: 10,
    left: {
      val: 8,
      left: {val: 4},
      right: {val: 9}
    },
    right: {
      val: 13,
      right: {val: 15}
    }
  }
  ); // returns true
```

### Custom validators

You can make your own custom validators, provided they implement the `Validator` interface:
```javascript
type Validator = {
  isValid (val: mixed): boolean;
  getValidationResult (val: mixed): ValidationResult;
}

type ValidationResult =
  {isValid: 'true'} |
  {isValid: 'false', message: string, score: number}
```

Example:
```javascript
import {isValid} from 'shapely';

const Tuple = {
  isValid(val) {
    return Array.isArray(val) && val.length === 2;
  }

  getValidationResult(val) {
    if (!Array.isArray(val)) {
      return {
        isValid: 'false',
        message: `Array expected, ${typeof val} given.`,
        score: 0 // 0 means a complete type mismatch
      };
    } else if (val.lenth === 2) {
      return {isValid: 'true'};
    } else {
      return {
        isValid: 'false',
        message: `A tuple 2 two elements. ${val.length} given`,
        score: 1 // 1 means the general type matches, but the details don't.
      };
    }
  }
};

isValid(Tuple, [1, 2]); // returns true
isValid(Tuple, [1]); // returns false
validate(Tuple, [1, 2]); // returns [1, 2]
validate(Tuple, [1]); // throws Error: val.length is ecpected to be 2. 1 given
```

## Development

Shapely is itself written in Flow, but like all flow code, it still compiles if you don't have flow installed on your system. We use Babel for compilation, Webpack for bundling, and LiveScript for the tests.

To watch the files and recompile:
```
$ cd path/to/shapely
$ npm run dev
```

To run the tests:
```
$ npm test

or:
$ npm run test:watch
```

## License

MIT