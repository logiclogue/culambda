module Evaluator where

import Expr (Expr (..))

eval_expr :: Expr -> (String -> Expr) -> Expr
eval_expr (App (Lambda var expr_a) expr_b) env =
    eval_expr expr_a (\x -> if x == var then expr_b else env x)

eval_expr (App (NativeFunction f) expr) env =
    eval_expr (f (eval_expr expr env)) env

eval_expr (App expr_a expr_b) env =
    eval_expr (App (eval_expr expr_a env) expr_b) env

eval_expr (Lambda var expr_a) env =
    Lambda var expr_a

eval_expr (NativeFunction f) env =
    NativeFunction f

eval_expr (Symbol s) env =
    eval_expr (env s) env

eval_expr (N n) env =
    N n
