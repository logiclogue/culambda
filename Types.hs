module Types where

data Type
    = Number
    | Function (Type, Type)
    | ForAll String Type
    | TypeSymbol String

instance Show Type where

    show Number =
        "Number"

    show (Function (t1, t2)) =
        show t1 ++ " -> " ++ show t2

    show (ForAll var t) =
        "forall " ++ var ++ ". " ++ show t

    show (TypeSymbol var) =
        var