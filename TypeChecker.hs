module TypeChecker where

import Types (Type(..))
import Expr (Expr(..))

expr_type :: Expr -> (String -> Type) -> Type
eval_type (App (Lambda var expr_a) expr_b) env =
    eval_type expr_a (\x -> if x == var then expr_b else env x)

eval_type (App (NativeFunction f) expr) env =
    eval_type (f (eval_type expr env)) env

eval_type (App expr_a expr_b) env =
    eval_type (App (eval_type expr_a env) expr_b) env

eval_type (Lambda var expr_a) env =
    ForAll "a" (Function (Symbol "a", eval_type expr_a))

eval_type (NativeFunction f) env =
    ForAll "a" (ForAll "b" (Function (Symbol "a", Symbol "b")))

eval_type (Symbol s) env =
    eval_type (env s) env

eval_type (N _) _ =
    Number
