import Expr (Expr (..))
import Evaluator (eval_expr)
import Parser (parse_expr)

data TypeExpr = Func TypeExpr TypeExpr
              | TypeInt Int

my_prelude :: String -> Expr
my_prelude "jordan" = (Lambda "x" (Symbol "x"))
my_prelude "succ" = (NativeFunction (\(N x) -> N (x + 1)))
my_prelude "add" = (NativeFunction (\(N x) -> NativeFunction (\(N y) -> N (x + y))))

main :: IO ()
main = do
    input <- getLine

    case parse_expr input of
        Just x  -> (print . flip eval_expr my_prelude) x
        Nothing -> print ("failed to parse after: " ++ input)
