import Expr (Expr (..))
import Evaluator (eval_expr)
import Parser (parse_expr)
import Types

data TypeExpr = Func TypeExpr TypeExpr
              | TypeInt Int

my_prelude :: String -> Expr
my_prelude "jordan" = (Lambda "x" (Symbol "x"))
my_prelude "succ" = (NativeFunction (\(N x) -> N (x + 1)))
my_prelude "add" = (NativeFunction (\(N x) -> NativeFunction (\(N y) -> N (x + y))))

type_prelude :: [TypeContext]
type_prelude =
    [
        TypeContextAssign "jordan" (PolyTypeForAll "a"
            (PolyTypeMono (MonoTypeApp (MonoTypeApp
                (MonoTypeVar "->") (MonoTypeVar "a")) MonoTypeVar "a")),
        TypeContextAssign "succ" (PolyTypeMono (MonoTypeApp (MonoTypeApp
            (MonoTypeVar "->") (MonoTypeVar "Number")) (MonoTypeVar "Number"))),
        TypeContextAssign "add" (PolyTypeMono
            (MonoTypeApp
                (MonoTypeApp
                    (MonoTypeVar "->")
                    (MonoTypeApp
                        (MonoTypeApp (MonoTypeVar "->") (MonoTypeVar "Number"))
                        (MonoTypeVar "Number")))
                (MonoTypeVar "Number")))
    ]

main :: IO ()
main = do
    input <- getContents

    case parse_expr input of
        Just x  -> (print . flip eval_expr my_prelude) x
        Nothing -> print ("Failed to parse after: " ++ input)
