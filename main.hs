import Text.Yoda

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
eval_expr (App (Lambda var expr_a) expr_b) env = eval_expr expr_a (\x -> if x == var then expr_b else env x)
eval_expr (App expr_a expr_b) env = eval_expr (App (eval_expr expr_a env) expr_b) env
eval_expr (Lambda var expr_a) env = Lambda var expr_a
eval_expr (Symbol s) env = eval_expr (env s) env
eval_expr (N n) env = N n

my_env :: String -> Expr
my_env "jordan" = (Lambda "x" (Symbol "x"))

parse_expr :: Parser Expr
parse_expr = Lambda <$ string "(lambda (" <*> string "x" <* string ") " <*> parse_expr <* string ")"
         <|> App <$ string "(" <*> parse_expr <* string " " <*> parse_expr <* string ")"
         <|> Symbol <$> string "x"

main :: IO ()
main = print "hello"
