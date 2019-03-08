module Parser where

import Text.Yoda
import Expr
import Data.Char (isAlpha, isDigit, isSeparator)
import Data.List (find)

identifier :: Parser String
identifier =
    some (satisfy isAlpha)

whitespace :: Parser String
whitespace =
    some (satisfy isSeparator)

optional_whitespace :: Parser String
optional_whitespace =
    many (satisfy isSeparator)

lambda_parser :: Parser Expr
lambda_parser =
    Lambda
        <$ string "(" <*> identifier <* whitespace <* string "->" <* whitespace
        <*> expr_parser <* string ")"

app_parser :: Parser Expr
app_parser =
    App
        <$ string "(" <* (many (satisfy isSeparator)) <*> expr_parser
        <* whitespace <*> expr_parser <* optional_whitespace <* string ")"

symbol_parser :: Parser Expr
symbol_parser =
    Symbol <$> identifier

number_parser :: Parser Expr
number_parser =
    (N . read) <$> some (satisfy isDigit)

let_parser :: Parser Expr
let_parser =
    (\var x expr -> App (Lambda var expr) x)
        <$ string "let" <* whitespace <*> identifier <* optional_whitespace
        <* string "=" <* optional_whitespace <*> expr_parser <* whitespace
        <* string "in" <* whitespace <*> expr_parser

expr_parser :: Parser Expr
expr_parser =
    lambda_parser
    <|> app_parser
    <|> symbol_parser
    <|> number_parser
    <|> let_parser

parse_expr :: String -> Maybe Expr
parse_expr = (fst <$>) . find (\(_, s) -> length s == 0) . parse expr_parser
