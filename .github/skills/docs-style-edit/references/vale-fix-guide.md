# Vale fix guide

How to interpret and resolve common vale rule violations.

## Reading vale output

```console
docs/deploy.md:14:5  warning  Use 'select' instead of 'click'.       Google.WordList
docs/deploy.md:22:1  error    'utilize' is a non-standard word.       Microsoft.Avoid
docs/deploy.md:37:8  warning  Avoid passive voice.                    write-good.Passive
docs/deploy.md:51:3  error    'e.g.' is a Latin abbreviation.         Google.Latin
```

Each line: `file:line:col  severity  message  package.RuleName`

Fix in order: **errors** → **warnings** → **suggestions**.

---

## Common Google style rules

| Rule | What it flags | Fix |
|------|--------------|-----|
| `Google.WordList` | Forbidden words: "click", "utilize", "via", "e.g.", "i.e.", "please" | Use the approved replacement in the message |
| `Google.Passive` | Passive voice constructions | Rewrite with explicit subject: "The command returns X" not "X is returned" |
| `Google.Headings` | Title case in headings | Convert to sentence case: "Configure The Server" → "Configure the server" |
| `Google.Contractions` | Expanded contractions: "do not", "cannot", "it is" | Contract them: "don't", "can't", "it's" |
| `Google.Exclamation` | Exclamation marks | Remove them |
| `Google.FirstPerson` | First person pronouns: "I", "we", "our" | Rewrite in second person: "you", "your" |
| `Google.Latin` | Latin abbreviations: "e.g.", "i.e.", "etc.", "via" | Spell them out: "for example", "that is", "and so on", "through" |
| `Google.Ellipses` | Ellipses (`...`) in prose | Remove or rewrite the sentence |
| `Google.OxfordComma` | Missing serial (Oxford) comma in a list | Add the comma before the final "and" or "or" |

---

## Common Microsoft style rules

| Rule | What it flags | Fix |
|------|--------------|-----|
| `Microsoft.Avoid` | Banned words and phrases | Use the replacement named in the message |
| `Microsoft.Passive` | Passive voice | Rewrite with active subject |
| `Microsoft.Contractions` | Formal constructions: "do not", "cannot" | Shorten to contractions |
| `Microsoft.Headings` | Title-cased headings | Convert to sentence case |
| `Microsoft.Vocab` | Informal or incorrect terms | Use the correct term from the message |
| `Microsoft.Adverbs` | Weak adverbs: "very", "quite", "really" | Remove the adverb or strengthen the adjective |
| `Microsoft.Wordiness` | Wordy phrases: "in order to", "due to the fact that" | Replace with concise alternatives: "to", "because" |

---

## Common Vale built-in rules

| Rule | What it flags | Fix |
|------|--------------|-----|
| `Vale.Spelling` | Possible spelling errors | Correct the spelling, or add to the vocab accept list if it's a valid term |
| `Vale.Repetition` | Repeated words: "the the", "to to" | Remove the duplicate |

---

## Handling false positives

If vale flags a correctly spelled product name, command, or abbreviation, don't change the text.
Instead, add the term to the vocabulary accept list:

1. Open `.vale/styles/Vocab/Base/accept.txt` (create it if it doesn't exist).
2. Add the term, one per line.
3. Re-run vale to confirm the false positive is resolved.

Common terms to add for DevOps docs:

```
Kubernetes
kubectl
GitOps
IaC
Terraform
Helm
containerd
etcd
Prometheus
Grafana
```

---

## Handling code blocks

Vale lints inside fenced code blocks.
Wrap them with suppression comments if vale incorrectly flags command syntax or output:

```markdown
<!-- vale off -->
```shell
kubectl get pods -n <namespace> --field-selector=status.phase!=Running
```
<!-- vale on -->
```

---

## Handling suggestions

Suggestions are optional improvements — apply them when the fix clearly makes the text better,
skip them when the rewrite would be awkward.

If a suggestion is worth revisiting later, add a comment:

```markdown
<!-- TODO: consider simplifying this sentence -->
```

Don't block a doc from publication over unresolved suggestions.
