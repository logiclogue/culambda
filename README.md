# Lisp

Lisp-like programming language implemented in Haskell.

## Semantics

The language has five main constructs: lambda functions, function application,
symbols, native functions, and integers.

## Syntax

Lambda functions:

```
(x -> expr)
```

Function application:

```
(f x)
```

Symbols:

```
x
```

## Syntactic Sugar

This expression...

```
let var = expr_a in

expr_b
```

is syntactic sugar for this expression...

```
(var -> expr_b) expr_a
```

`let` syntax is implemented in the language's parser.

## Type System

Symbols:

```
x : env x else forall a. a
```

Lambda functions:

```
(x -> expr_a) : forall a. a -> (type of expr_a with a in the environment)
```

Function application:

```
(f x) : return type of f
```

How to evaluate the `forall a. a` case? It's a special type of type. **TODO**

## Type Checker

Symbols:

```
x => true
```

Lambda functions:

```
(x -> expr_a) => true if expr_a type checks with x in the environment
```

Function application:

```
(f x) => true if type of x is the input type of f
```
