module TypeChecker where

import Types (Type(..))
import Expr (Expr(..))

expr_type :: Expr -> Type
expr_type (Lambda var expr) =
    ForAll var (expr_type expr)

--expr_type (App expr_a expr_b) =
--    
--
--          | Symbol String
--          | NativeFunction (Expr -> Expr)
--          | N Int

expr_type (N _) =
    Number
