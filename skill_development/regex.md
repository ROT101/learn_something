# 1.  Basic Characters

    . (dot): Matches any single character except a newline.

    ^: Matches the start of a string.

    $: Matches the end of a string.

# 2.  Character Classes

    Square Brackets: [abc] matches any single character a, b, or c.

    Ranges: [a-z] matches any lowercase letter from a to z.

    Negation: [^abc] matches any character except a, b, or c.

# 3. Quantifiers

    *: Matches 0 or more occurrences of the preceding element.

    +: Matches 1 or more occurrences of the preceding element.

    ?: Matches 0 or 1 occurrence of the preceding element.

    {n}: Matches exactly n occurrences of the preceding element.

    {n,}: Matches n or more occurrences.

    {n,m}: Matches between n and m occurrences.

# 4. Anchors

    ^: Asserts the position at the start of a string.

    $: Asserts the position at the end of a string.

# 5. Groups and Capturing

    Parentheses: (...) groups patterns and captures the matched text.

    on-capturing groups: (?:...) groups patterns without capturing.

# 6. Alternation

    Pipe |: Acts as a logical OR. For example, cat|dog matches either "cat" or "dog".

# 7. Escape Sequences
    Backslash \: Escapes a metacharacter to treat it as a literal character. For example, \. matches a literal dot.

# 8. Special Sequences

    \d: Matches any digit (equivalent to [0-9]).

    \D: Matches any non-digit.

    \w: Matches any word character (alphanumeric + underscore, equivalent to [a-zA-Z0-9_]).

    \W: Matches any non-word character.

    \s: Matches any whitespace character (spaces, tabs, line breaks).

    \S: Matches any non-whitespace character.

# 9. Flags/Modifiers

    Case Insensitivity: Often denoted by i, e.g., /pattern/i.

    Multiline: Often denoted by m, which allows ^ and $ to match the start and end of each line.

    Dot All: Often denoted by s, which allows . to match newline characters.

### Example Patterns

    Email Address: A regex for matching an email might look like:

    /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

    Phone Number: A regex for matching a phone number could be:

    /^\$\d{3}\$ \d{3}-\d{4}$/
