module Expr where

data Expr = Lambda String Expr
          | App Expr Expr
          | Symbol String
          | NativeFunction (Expr -> Expr)
          | N Int

instance Show Expr where

    show (Lambda s expr) =
        "(lambda (" ++ s ++ ") " ++ (show expr) ++ ")"

    show (App expr_a expr_b) =
        "(" ++ (show expr_a) ++ " " ++ (show expr_b) ++ ")"

    show (Symbol s) =
        s

    show (NativeFunction _) =
        "<native function>"

    show (N n) =
        show n
