# spellcheck

A different type of spellchecker, written in Haskell.

Inspired by [Norvig's spelling corrector](http://norvig.com/spell-correct.html). I read this and thought it was cool, but was irritated by what I thought was a glaring omission in the spell checker's design: it didn't take into account key locations.

For example, according to Norvig's corrector, the misspelling `vate` could be either `gate` or `late` with about equal likelihood (since they're both just one edit away from `vate`). In fact, it would guess 'late', since that's a slightly more common word. However, looking down at our (U.S. layout) keyboard, we immediately see that of course the likelihood isn't equal! The letter `v` on the keyboard is just one key away from `g`, whereas it's **six** letters away from `l`, so we can clearly see that the person probably meant to type `gate` but missed the `g` key with their finger: but `v` is nowhere near `l`.

Part of the charm of the Norvig corrector is how short the program is, so I tried to write an equally small program which implemented the idea of key distance to rank the quality of the edits (instead of word frequency, as in the Norvig one). 

**NOTE**, this spellchecker might perform equally terribly as the Norvig corrector, just in very different ways. For example, on input `sfore`, it ranks `afore` and `score` as equally likely corrections, but normal people don't use the word "afore" very much -- they probably wanted "score". I believe one could make a truly great spellchecker by taking both English-language word frequency _and_ key distance into account when suggesting edits, and this is just a demonstration of the latter.

### Instructions

No libraries are used other than a modern `ghc`. Only good for US-layout keyboards!

Compile: Clone the repo and then `ghc -O2 main.hs`

Run: `./main speling`, will return an ugly list of its best guesses for a correction of `speling`