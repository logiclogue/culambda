import Test.Hspec

main :: IO ()
main =
    hspec $ do
        describe "Prelude.head" $ do
            it "returns the first element of a list" $ do
                print "HERE"
                head [1, 2, 3] `shouldBe` (1 :: Int)
    
