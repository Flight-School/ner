# ner

`ner` is a command-line utility for performing
<dfn>named entity recognition</dfn> (<abbr>NER</abbr>) on text.
You can use it to extract names of people, places, and organizations
from standard input or file arguments.

```terminal
$ echo "Designed by Apple in California." | ner
ORGANIZATION	Apple
PLACE	California
```

---

For more information about natural language processing,
check out Chapter 7 of the
[Flight School Guide to Swift Strings](https://flight.school/books/strings).

---

## Requirements

- macOS 10.12+

## Usage

Text can be read from either standard input or file arguments,
and named entities are written to standard output on separate lines.

### Reading from Piped Standard Input

```terminal
$ echo "Tim Cook is the CEO of Apple." | ner
PERSON	Tim Cook
ORGANIZATION	Apple
```

### Reading from Standard Input Interactively

```terminal
$ ner
Greetings from Cupertino, California! (This text is being typed into standard input.)
PLACE	Cupertino
PLACE	California
```

### Reading from a File

```terminal
$ cat barton.txt
The American Red Cross was established in Washington DC by Clara Barton.

$ ner barton.txt
ORGANIZATION	American Red Cross
PLACE	Washington DC
PERSON	Clara Barton
```

### Reading from Multiple Files

```terminal
$ cat lincoln.txt
Abraham Lincoln was the 16th President of the United States of America.

$ ner barton.txt lincoln.txt
ORGANIZATION	American Red Cross
PLACE	Washington DC
PERSON	Clara Barton
PERSON	Abraham Lincoln
PLACE	United States of America
```

## Advanced Usage

`ner` can be chained with
[Unix text processing commands](https://en.wikibooks.org/wiki/Guide_to_Unix/Commands/Text_Processing),
like `cut`, `sort`, `uniq`, `comm`, `grep` `sed`, and `awk`.

### Filtering Tags

```terminal
$ ner barton.txt | cut -f2
American Red Cross
Washington DC
Clara Barton
```

## Additional Details

Named entities are written to standard output on separate lines.
Each line consists of
the tag (`PERSON`, `PLACE`, or `ORGANIZATION`),
followed by a tab (`\t`),
followed by the token:

```regexp
^(?<tag>(?>PERSON|PLACE|ORGANIZATION))\t(?<token>.+)$
```

`ner` uses
[`NLTagger`](https://developer.apple.com/documentation/naturallanguage/nltagger)
when available,
falling back on
[`NSLinguisticTagger`](https://developer.apple.com/documentation/foundation/nslinguistictagger)
for older versions of macOS.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))
