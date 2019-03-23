module Types where

data MonoType
    = MonoTypeVar String
    | MonoTypeApp MonoType MonoType

data PolyType
    = PolyTypeMono MonoType
    | PolyTypeForAll String PolyType

data TypeContext
    = TypeContextEmpty
    | TypeContextAssign String PolyType

data Typing = Typing Expr PolyType
