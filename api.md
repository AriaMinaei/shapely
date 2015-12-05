# TOC
   - [createValidator](#createvalidator)
   - [isValid()](#isvalid)
   - [validate()](#validate)
   - [ArrayOfValidator](#arrayofvalidator)
     - [::isValid()](#arrayofvalidator-isvalid)
     - [::getValidationResult()](#arrayofvalidator-getvalidationresult)
   - [DeferredValidator](#deferredvalidator)
     - [::isValid()](#deferredvalidator-isvalid)
     - [::getValidationResult()](#deferredvalidator-getvalidationresult)
   - [ExactValueValidator](#exactvaluevalidator)
     - [::isValid()](#exactvaluevalidator-isvalid)
     - [::getValidationResult()](#exactvaluevalidator-getvalidationresult)
   - [MapOfValidator](#mapofvalidator)
     - [::isValid()](#mapofvalidator-isvalid)
     - [::getValidationResult()](#mapofvalidator-getvalidationresult)
   - [OptionalValidator](#optionalvalidator)
     - [::isValid()](#optionalvalidator-isvalid)
     - [::getValidationResult()](#optionalvalidator-getvalidationresult)
   - [RecordValidator](#recordvalidator)
     - [::constructor()](#recordvalidator-constructor)
     - [::isValid()](#recordvalidator-isvalid)
     - [::getValidationResult()](#recordvalidator-getvalidationresult)
   - [UnionValidator](#unionvalidator)
     - [::constructor()](#unionvalidator-constructor)
     - [::isValid()](#unionvalidator-isvalid)
     - [::getValidationResult()](#unionvalidator-getvalidationresult)
   - [anyValidator](#anyvalidator)
     - [::isValid()](#anyvalidator-isvalid)
     - [::getValidationResult()](#anyvalidator-getvalidationresult)
   - [booleanValidator](#booleanvalidator)
     - [::isValid()](#booleanvalidator-isvalid)
     - [::getValidationResult()](#booleanvalidator-getvalidationresult)
   - [nilValidator](#nilvalidator)
     - [::isValid()](#nilvalidator-isvalid)
     - [::getValidationResult()](#nilvalidator-getvalidationresult)
   - [numberValidator](#numbervalidator)
     - [::isValid()](#numbervalidator-isvalid)
     - [::getValidationResult()](#numbervalidator-getvalidationresult)
   - [stringValidator](#stringvalidator)
     - [::isValid()](#stringvalidator-isvalid)
     - [::getValidationResult()](#stringvalidator-getvalidationresult)
<a name=""></a>
 
<a name="createvalidator"></a>
# createValidator
should turn String into stringValidator.

```js
var x$;
x$ = createValidator(String);
x$.isValid('hello').should.equal(true);
x$.isValid(12).should.equal(false);
```

should turn Number into numberValidator.

```js
var x$;
x$ = createValidator(Number);
x$.isValid(10).should.equal(true);
x$.isValid('hello').should.equal(false);
```

should turn Boolean into booleanValidator.

```js
var x$;
x$ = createValidator(Boolean);
x$.isValid(false).should.equal(true);
x$.isValid('hello').should.equal(false);
```

should turn strings into ExactValueValidator.

```js
var x$;
x$ = createValidator('hello');
x$.isValid('hello').should.equal(true);
x$.isValid('a').should.equal(false);
```

should turn numbers into ExactValueValidator.

```js
var x$;
x$ = createValidator(10);
x$.isValid(10).should.equal(true);
x$.isValid(11).should.equal(false);
```

should turn booleans into ExactValueValidator.

```js
var x$;
x$ = createValidator(false);
x$.isValid(false).should.equal(true);
x$.isValid(11).should.equal(false);
```

should act like identity() if supplied with a Validator.

```js
var validator;
validator = record({
  a: String
});
createValidator(validator).should.equal(validator);
```

<a name="isvalid"></a>
# isValid()
should create validator on the fly if needed.

```js
(function(){
  return isValid(String, "hello");
}).should.not['throw']();
(function(){
  return isValid(record({
    a: String
  }), {
    a: 'hello'
  });
}).should.not['throw']();
```

should return value if value matches.

```js
isValid(String, "hello").should.equal(true);
```

should throw if value doesn't match.

```js
isValid(String, 10).should.equal(false);
```

<a name="validate"></a>
# validate()
should create validator on the fly if needed.

```js
(function(){
  return validate(String, "hello");
}).should.not['throw']();
(function(){
  return validate(record({
    a: String
  }), {
    a: 'hello'
  });
}).should.not['throw']();
```

should return value if value matches.

```js
validate(String, "hello").should.equal("hello");
```

should throw if value doesn't match.

```js
(function(){
  return validate(String, 10);
}).should['throw']();
```

<a name="arrayofvalidator"></a>
# ArrayOfValidator
should be recognized.

```js
(function(){
  return createValidator(arrayOf(Number));
}).should.not['throw']();
```

<a name="arrayofvalidator-isvalid"></a>
## ::isValid()
should validate empty arrays.

```js
validator.isValid([]).should.equal(true);
```

should validate correct arrays.

```js
validator.isValid([1, 2, 3]).should.equal(true);
```

should only validate correct arrays.

```js
validator.isValid([1, 2, 'hello']).should.equal(false);
```

should only validate arrays.

```js
validator.isValid(12).should.equal(false);
```

<a name="arrayofvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate empty arrays.

```js
validator.getValidationResult([]).should.be.like({
  isValid: 'true'
});
```

should validate correct arrays.

```js
validator.getValidationResult([1, 2, 3]).should.be.like({
  isValid: 'true'
});
```

should only validate correct arrays.

```js
var x$;
x$ = validator.getValidationResult([1, 2, 'hello']);
x$.isValid.should.equal('false');
x$.score.should.equal(1);
```

should only validate arrays.

```js
var x$;
x$ = validator.getValidationResult(12);
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="deferredvalidator"></a>
# DeferredValidator
should be recognized.

```js
(function(){
  return createValidator(deferred(function(){
    return Number;
  }));
}).should.not['throw']();
```

<a name="deferredvalidator-isvalid"></a>
## ::isValid()
should validate matches.

```js
validator.isValid(12).should.equal(true);
```

should only validate matches.

```js
validator.isValid('hello').should.equal(false);
```

<a name="deferredvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate matches.

```js
validator.getValidationResult(12).should.be.like({
  isValid: 'true'
});
```

should only validate matches.

```js
var x$;
x$ = validator.getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="exactvaluevalidator"></a>
# ExactValueValidator
should be recognized.

```js
(function(){
  return createValidator('hello');
}).should.not['throw']();
```

<a name="exactvaluevalidator-isvalid"></a>
## ::isValid()
should validate exact value.

```js
createValidator('hello').isValid('hello').should.equal(true);
```

should only validate exact value.

```js
createValidator(12).isValid(13).should.equal(false);
```

<a name="exactvaluevalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate exact value.

```js
createValidator(true).getValidationResult(true).should.be.like({
  isValid: 'true'
});
```

should only validate exact value.

```js
var x$;
x$ = createValidator('hello').getValidationResult(12);
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="mapofvalidator"></a>
# MapOfValidator
should be recognized.

```js
(function(){
  return createValidator(mapOf(Number));
}).should.not['throw']();
```

<a name="mapofvalidator-isvalid"></a>
## ::isValid()
should validate empty objects.

```js
validator.isValid({}).should.equal(true);
```

should validate correct objects.

```js
validator.isValid({
  a: 1,
  b: 2
}).should.equal(true);
```

should only validate correct objects.

```js
validator.isValid({
  a: 1,
  b: 'hello'
}).should.equal(false);
```

should only validate objects.

```js
validator.isValid(12).should.equal(false);
```

<a name="mapofvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate empty objects.

```js
validator.getValidationResult({}).should.be.like({
  isValid: 'true'
});
```

should validate correct objects.

```js
validator.getValidationResult({
  a: 1,
  b: 2
}).should.be.like({
  isValid: 'true'
});
```

should only validate correct objects.

```js
var x$;
x$ = validator.getValidationResult({
  a: 1,
  b: 'hello'
});
x$.isValid.should.equal('false');
x$.score.should.equal(1);
```

should only validate objects.

```js
var x$;
x$ = validator.getValidationResult(12);
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="optionalvalidator"></a>
# OptionalValidator
should be recognized.

```js
(function(){
  return createValidator(optional(Number));
}).should.not['throw']();
```

<a name="optionalvalidator-isvalid"></a>
## ::isValid()
should validate matches.

```js
createValidator(optional(Number)).isValid(12).should.equal(true);
```

should validate nils.

```js
createValidator(optional(Number)).isValid(null).should.equal(true);
```

should not validate non-matches.

```js
createValidator(optional(Number)).isValid('hello').should.equal(false);
```

<a name="optionalvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate matches.

```js
createValidator(optional(Number)).getValidationResult(12).should.be.like({
  isValid: 'true'
});
```

should validate nils.

```js
createValidator(optional(Number)).getValidationResult(undefined).should.be.like({
  isValid: 'true'
});
```

should only not validate non-matches.

```js
var x$;
x$ = createValidator(optional(Number)).getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="recordvalidator"></a>
# RecordValidator
should be recognized.

```js
(function(){
  return createValidator(record({
    a: String
  }));
}).should.not['throw']();
```

<a name="recordvalidator-constructor"></a>
## ::constructor()
should only accept objects.

```js
(function(){
  return record({
    a: String
  });
}).should.not['throw']();
(function(){
  return record([]);
}).should['throw']();
```

<a name="recordvalidator-isvalid"></a>
## ::isValid()
should validate matches.

```js
validator.isValid({
  a: 'hello',
  b: 12
}).should.equal(true);
```

should validate ignore extra properties.

```js
validator.isValid({
  a: 'hello',
  b: 12,
  c: 13
}).should.equal(true);
```

should only validate matches.

```js
validator.isValid({
  a: 'hello',
  b: 'hello'
}).should.equal(false);
```

<a name="recordvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate matches.

```js
validator.getValidationResult({
  kind: 'leaf',
  value: 12
}).isValid.should.equal('true');
```

should ignore extra properties.

```js
validator.getValidationResult({
  kind: 'leaf',
  value: 12,
  extra: []
}).isValid.should.equal('true');
```

should only validate objects and return correct score.

```js
var x$, y$;
x$ = validator.getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
y$ = validator.getValidationResult({});
y$.isValid.should.equal('false');
y$.score.should.equal(1);
```

should only validate matches and return correct score.

```js
var x$, y$, z$;
x$ = validator.getValidationResult({
  kind: 'wrong',
  value: 12
});
x$.isValid.should.equal('false');
x$.score.should.equal(1);
y$ = validator.getValidationResult({
  kind: 'leaf',
  value: 'hello'
});
y$.isValid.should.equal('false');
y$.score.should.equal(2);
z$ = validator.getValidationResult({
  kind: 'wrong',
  value: 12
});
z$.isValid.should.equal('false');
z$.score.should.equal(1);
```

<a name="unionvalidator"></a>
# UnionValidator
should be recognized.

```js
(function(){
  return createValidator(union(record({
    a: String
  }), String));
}).should.not['throw']();
```

<a name="unionvalidator-constructor"></a>
## ::constructor()
should only accept validators.

```js
(function(){
  return union(String, Number);
}).should.not['throw']();
(function(){
  return union(String, null);
}).should['throw']();
```

<a name="unionvalidator-isvalid"></a>
## ::isValid()
should validate all variants.

```js
validator.isValid('hello').should.equal(true);
validator.isValid({
  kind: 'leaf'
}).should.equal(true);
```

should only validate variants.

```js
validator.isValid(0).should.equal(false);
```

<a name="unionvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate all variants.

```js
var x$, y$;
x$ = validator.getValidationResult('hello');
x$.isValid.should.equal('true');
y$ = validator.getValidationResult({
  kind: 'leaf',
  value: 12
});
y$.isValid.should.equal('true');
```

should only validate variants.

```js
var x$;
x$ = validator.getValidationResult(0);
x$.isValid.should.equal('false');
```

should return the best matched score.

```js
var x$, y$, z$;
x$ = validator.getValidationResult(0);
x$.score.should.equal(0);
y$ = validator.getValidationResult({});
y$.score.should.equal(1);
z$ = validator.getValidationResult({
  kind: 'leaf'
});
z$.score.should.equal(2);
```

<a name="anyvalidator"></a>
# anyValidator
should be recognized.

```js
(function(){
  return createValidator(any);
}).should.not['throw']();
```

<a name="anyvalidator-isvalid"></a>
## ::isValid()
should validate any value.

```js
var validator, i$, ref$, len$, value;
validator = createValidator(any);
for (i$ = 0, len$ = (ref$ = [null, 1, 's', {}, [], new Date(), fn$]).length; i$ < len$; ++i$) {
  value = ref$[i$];
  validator.isValid(value).should.equal(true);
}
function fn$(){}
```

<a name="anyvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate any value.

```js
var validator, i$, ref$, len$, value;
validator = createValidator(any);
for (i$ = 0, len$ = (ref$ = [null, 1, 's', {}, [], new Date(), fn$]).length; i$ < len$; ++i$) {
  value = ref$[i$];
  validator.getValidationResult(value).should.be.like({
    isValid: 'true'
  });
}
function fn$(){}
```

<a name="booleanvalidator"></a>
# booleanValidator
should be recognized.

```js
(function(){
  return createValidator(Boolean);
}).should.not['throw']();
```

<a name="booleanvalidator-isvalid"></a>
## ::isValid()
should validate booleans.

```js
createValidator(Boolean).isValid(true).should.equal(true);
```

should only validate booleans.

```js
createValidator(Boolean).isValid('hello').should.equal(false);
```

<a name="booleanvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate booleans.

```js
createValidator(Boolean).getValidationResult(false).should.be.like({
  isValid: 'true'
});
```

should only validate booleans.

```js
var x$;
x$ = createValidator(Boolean).getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="nilvalidator"></a>
# nilValidator
should be recognized.

```js
(function(){
  return createValidator(nil);
}).should.not['throw']();
```

<a name="nilvalidator-isvalid"></a>
## ::isValid()
should validate null.

```js
createValidator(nil).isValid(null).should.equal(true);
```

should validate undefined.

```js
createValidator(nil).isValid(undefined).should.equal(true);
```

should only validate nil values.

```js
createValidator(nil).isValid('hello').should.equal(false);
```

<a name="nilvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate null.

```js
createValidator(nil).getValidationResult(null).should.be.like({
  isValid: 'true'
});
```

should validate undefined.

```js
createValidator(nil).getValidationResult(undefined).should.be.like({
  isValid: 'true'
});
```

should only validate nil values.

```js
var x$;
x$ = createValidator(nil).getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="numbervalidator"></a>
# numberValidator
should be recognized.

```js
(function(){
  return createValidator(Number);
}).should.not['throw']();
```

<a name="numbervalidator-isvalid"></a>
## ::isValid()
should validate numbers.

```js
createValidator(Number).isValid(12).should.equal(true);
```

should only validate numbers.

```js
createValidator(Number).isValid('hello').should.equal(false);
```

<a name="numbervalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate numbers.

```js
createValidator(Number).getValidationResult(12).should.be.like({
  isValid: 'true'
});
```

should only validate numbers.

```js
var x$;
x$ = createValidator(Number).getValidationResult('hello');
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

<a name="stringvalidator"></a>
# stringValidator
should be recognized.

```js
(function(){
  return createValidator(String);
}).should.not['throw']();
```

<a name="stringvalidator-isvalid"></a>
## ::isValid()
should validate strings.

```js
createValidator(String).isValid('hello').should.equal(true);
```

should only validate strings.

```js
createValidator(String).isValid(12).should.equal(false);
```

<a name="stringvalidator-getvalidationresult"></a>
## ::getValidationResult()
should validate strings.

```js
createValidator(String).getValidationResult('hello').should.be.like({
  isValid: 'true'
});
```

should only validate strings.

```js
var x$;
x$ = createValidator(String).getValidationResult(12);
x$.isValid.should.equal('false');
x$.score.should.equal(0);
```

