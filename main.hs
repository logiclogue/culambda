import Text.Yoda
import Data.Char (isAlpha, isDigit, isSeparator)

data TypeExpr = Func TypeExpr TypeExpr
              | TypeInt Int

data Expr = Lambda String Expr
          | App Expr Expr
          | Symbol String
          | N Int

instance Show Expr where

    show (Lambda s expr) = "(lambda (" ++ s ++ ") " ++ (show expr) ++ ")"
    show (App expr_a expr_b) = "(" ++ (show expr_a) ++ " " ++ (show expr_b) ++ ")"
    show (Symbol s) = s
    show (N n) = show n

eval_expr :: Expr -> (String -> Expr) -> Expr
eval_expr (App (Lambda var expr_a) expr_b) env =
    eval_expr expr_a (\x -> if x == var then expr_b else env x)

eval_expr (App expr_a expr_b) env =
    eval_expr (App (eval_expr expr_a env) expr_b) env

eval_expr (Lambda var expr_a) env =
    Lambda var expr_a

eval_expr (Symbol s) env =
    eval_expr (env s) env

eval_expr (N n) env =
    N n

my_env :: String -> Expr
my_env "jordan" = (Lambda "x" (Symbol "x"))

identifier :: Parser String
identifier = some (satisfy isAlpha)

whitespace :: Parser String
whitespace =
    some (satisfy isSeparator)

optional_whitespace :: Parser String
optional_whitespace =
    many (satisfy isSeparator)

parse_expr :: Parser Expr
parse_expr =
    Lambda <$ string "(lambda" <* whitespace <* string "(" <*> identifier <* string ")" <* whitespace <*> parse_expr <* string ")"
    <|> App <$ string "(" <* (many (satisfy isSeparator)) <*> parse_expr <* whitespace <*> parse_expr <* optional_whitespace <* string ")"
    <|> Symbol <$> identifier
    <|> (N . read) <$> some (satisfy isDigit)

main :: IO ()
main = print "hello"
