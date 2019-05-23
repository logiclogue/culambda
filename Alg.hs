module Alg where

class Alg f a where
    alg :: f a -> a
