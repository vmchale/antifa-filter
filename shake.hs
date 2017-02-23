#!/usr/bin/env stack
{- stack --resolver lts-8.2 --install-ghc
    runghc
    --package shake
-}

import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

-- ideally should read filename from manifest etc.
main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="target"} $ do
    want ["target/wordfilter.crx", "target/wordfilter.zip"]

    phony "clean" $ do
        putNormal "Cleaning files in _build"
        removeFilesAfter "target" ["//*"]

    "target/wordfilter.crx" %> \out -> do
        need ["src.crx"]
        cmd "mv src.crx target/wordfilter.crx"

    "src.crx" %> \out -> do
        need [".wordfilter.pem"]
        cmd "./bash/crxmake src/ .wordfilter.pem"

    "target/wordfilter.zip" %> \out -> do
        need ["src/manifest.json"]
        cmd "zip -r target/wordfilter.zip . -i src/*"
