---
description: "Use when asking about doc structure, how to organize a document, or what sections to include. Covers structural templates for tutorials, how-to guides, reference docs, conceptual docs, release notes, and READMEs."
---

<!-- vale Microsoft.Quotes = NO -->
<!-- vale Microsoft.Contractions = NO -->

# Doc type structures

Source guidance: [The Good Docs Project](https://www.thegooddocsproject.dev/template/)

---

## Tutorial

**Purpose**: Learning-oriented. The reader follows a guided path and ends with a working result and new skills. Assumes no prior practical knowledge of the tool. Tutorials eliminate unexpected scenarios---engineer the reader toward a successful finish.

Tutorials differ from how-to guides: tutorials teach; how-to guides guide experienced users through a task.

```markdown
# <Title: what the reader will build or achieve>

One paragraph explaining what the reader will build and why it matters to a DevOps engineer.

## Overview

### Learning objectives

By the end of this tutorial, you'll be able to:

- <Skill or action the reader can perform>
- <Skill or action the reader can perform>

### Intended audience

Who this tutorial is for and what prior knowledge is assumed.

## Background (optional)

Any context the reader needs before starting---feature explanation, project structure, key concepts.
Keep this brief; link to conceptual docs for deeper explanations.

## Before you begin

- Prerequisite 1 (link to setup steps where applicable)
- Prerequisite 2

## Step 1: <Bare infinitive action---"Configure the namespace">

Introductory sentence explaining what this step accomplishes and why.

1. Step action. Start with an imperative verb.
2. Step action.

   ```shell
   # Comment explaining what this command does
   command --flag <value>
   ```

   Expected result: describe what the reader should see.

## Step 2: <Action>

...

## Summary

Recap the specific skills and knowledge the reader gained. Don't repeat the learning objectives
word-for-word---describe what they actually built or configured.

## Clean up (include if tutorial creates persistent or billable resources)

Steps to remove resources created during the tutorial.

## Next steps

- Link to a related how-to guide
- Link to a related conceptual doc or advanced tutorial
```

**Guidelines**:
- Tutorials should take 15–60 minutes to complete
- Keep steps to a maximum of 7 primary steps; maximum 4 substeps per step
- Each step builds on the previous one---don't jump ahead
- Show expected output after commands so the reader can verify success
- Use real, working examples---not placeholder logic
- Add comments to all code samples explaining what each part does
- Include a "Clean up" section whenever the tutorial creates persistent or billable resources

---

## How-to guide

**Purpose**: Task-oriented. Helps an experienced reader complete one specific task or solve one specific problem. Assumes the reader has practical knowledge and knows what they want to achieve. Alerts readers to unexpected scenarios; it doesn't eliminate them the way a tutorial does.

```markdown
# <Title: bare infinitive---"Deploy a container to Kubernetes">

One or two sentences describing the task and when a reader would perform it.
For example: "Use this guide to create a Kubernetes NetworkPolicy that restricts pod-to-pod traffic."

## Before you begin (include only for non-obvious prerequisites)

- Prerequisite: tool, permission, or environment needed
- Link to relevant setup docs

## <Task name: bare infinitive>

Introductory sentence describing what these steps accomplish.

1. Step one. Start with an imperative verb.
2. Step two.

   ```shell
   # Comment explaining the command
   command --flag <value>
   ```

   Expected output or result.

3. If <condition>, do <alternative step>.

## See also

- Link to a related how-to guide
- Link to a relevant conceptual doc or reference page
```

**Guidelines**:
- One how-to guide covers exactly one task
- Maximum 8–10 steps; if longer, split into multiple guides
- Use conditional imperatives for variations: "If you want X, do Y. To achieve Z, run..."
- Don't explain concepts in the steps---link to conceptual docs instead
- Document only the most common or recommended method; omit or link to alternative methods
- Alert readers to possible unexpected scenarios with `> **Note:**` or `> **Warning:**` admonitions
- Test instructions end-to-end before publishing; re-test after every notable product release

---

## Reference doc

**Purpose**: Provides accurate, complete technical information designed to be scanned, not read top to bottom. Mirrors the structure of the application or system it documents. Avoid high-level instructions or usage guides---link to how-to guides instead.

```markdown
# <Title: noun phrase---"kubectl rollout options">

One sentence describing what this reference covers.

## Syntax

`command [flags] <arguments>`

## Description

What the command, option set, or configuration does. Keep this concise.

## Options

| Flag / Option | Type | Default | Description |
|---------------|------|---------|-------------|
| `--flag` | string | `""` | What it does |
| `--required-flag` | int | required | What it does |

## Examples

```shell
# Description of what this example does
command --flag <value>
```

```shell
# Description of a second variation
command --flag <value> --other-flag
```

## Related

- Link to related reference page
- Link to related how-to guide
```

**Guidelines**:
- Every flag, option, and parameter must be documented; include type and default
- Use `required` in the Default column when there is no default value
- Examples must be present---at least two, showing different configurations
- Use active voice in descriptions: "Returns a JSON object" not "A JSON object is returned"
- Use tables and bulleted lists to maximize scannability
- Maintain consistent structure, terminology, and tone across all reference pages
- Don't include step-by-step procedures---link out to how-to guides

---

## Conceptual doc

**Purpose**: Helps readers understand a concept, architecture, or system. Provides foundational knowledge so readers can understand how-to guides and reference docs in context. Builds mental models; does not teach by doing.

Conceptual docs appear early in documentation journeys, or as mid-level layers when a reader encounters an unfamiliar concept in a how-to guide.

```markdown
# <Title: noun phrase---"Deployment strategies in Kubernetes">

(Optional) An introductory paragraph framing the concept's relevance and what the page covers.
Apply the inverted pyramid: start with the high-level idea, then go deeper.

## What is <concept>

A clear definition scoped to what this document covers. State what is in scope and, where useful,
what is out of scope. Explain how the concept fits into the broader system or workflow.
Use analogies where they help---prefer universally understood comparisons.

## (Optional) <Diagram or visual>

If a diagram clarifies the architecture or data flow, describe or embed it here, near the top.

## (Optional) Background

Historical context, design decisions, or industry context that affects how the concept works.
Include only if it meaningfully aids understanding.

## Use cases

When and why a DevOps engineer would use or encounter this concept.
Frame use cases around the reader's problems: what challenges does this concept solve?

## (Optional) Comparison

If the concept has multiple types, versions, or similar alternatives, include a comparison table.

| | When to use |
|---|-------------|
| <Option 1> | <Reason> |
| <Option 2> | <Reason> |

## Related resources

- Link to related conceptual doc
- Link to how-to guide that implements this concept
- Link to reference doc for this concept's options or configuration
```

**Guidelines**:
- One conceptual doc covers exactly one concept; if explaining a second concept becomes necessary, link to a separate doc
- Don't include step-by-step procedures---add a `<!-- TODO: link to how-to guide for [task] -->` comment where a procedure link should go
- Use the inverted pyramid: high-level overview first, details later
- Include a diagram whenever it clarifies structure, data flow, or relationships
- Explain trade-offs and limitations honestly

---

## Release notes

**Purpose**: Communicate new features, improvements, bug fixes, and known issues to stakeholders. Release notes are customer-facing---use plain language, not developer-facing changelog language. Written for both technical and non-technical readers.

```markdown
## <PRODUCT> <VERSION>

Release date: <MONTH> <DAY>, <YEAR>

(Optional) One to two sentences highlighting the most important items in this release.

### Breaking changes (include if present---always lead with this section)

> **Warning:** The following changes require action before upgrading.

- **<Change name>**: What changed, what the reader must do, and a link to the migration guide.

### New features

- **<Feature name>**: What the feature does and how it benefits the reader.
  See [<feature docs>](<link>) for more information.

### New features requiring configuration updates

- **<Feature name>**: What the feature does. To use this feature, you must <describe the required config>.
  See [<feature docs>](<link>) for configuration steps.

### Improvements

- **<Area or feature>**: What was added, updated, or removed and the benefit to the reader.

### Bug fixes

- **[<issue-id>](<link>) <Short description>**: <What the software now does correctly>.
  See [<docs link>](<link>) for more information.

### Known issues

- **[<issue-id>](<link>) <Short description>**: <What happens and in what scenario>.
  Workaround: <Steps to work around the issue, if available>.

### Deprecated features (optional)

- **<Feature name>**: <Feature> will be removed in <version or date>.
  <Replacement feature> replaces it. The system will <describe data migration if applicable>.
  See [<deprecated feature docs>](<link>).

### Packages

Packages are available for the following platforms and architectures:

| Platform | Architecture | Package format |
|----------|--------------|----------------|
| Windows | x86-64 | `.msi` |
| macOS | x86-64, ARM64 | `.pkg` |
| Red Hat Enterprise Linux, CentOS | x86-64, ARM64 | `.rpm` |
| Debian, Ubuntu | x86-64, ARM64 | `.deb` |
| Chef Habitat | x86-64, ARM64 | `.hart` |
```

**Guidelines**:
- Write in a positive, friendly tone; use plain language
- Use second person: "You can now...", "Use the new... to..."
- Use present tense for new features and improvements: "Adds support for...", "Lets you..."
- Use past tense for bug fixes: "Fixed an issue where...", "Resolved a problem that caused..."
- Don't start bug fix entries with "Fixed the bug..."---describe what the software now does correctly
- List the most important items in each section first
- Include issue or PR numbers and link them where your organization permits
- Omit any section that has no entries
- Use semantic versioning for release numbers (for example, `1.3.2`); include the date in `YYYY-MM-DD` format
- In the Packages section, list only the platforms and architectures available for the specific release; omit rows that don't apply

---

## Product overview

**Purpose**: Provides a high-level description of a product's value, capabilities, and use cases. This is often the entry point for developers, managers, and executives evaluating a product. Helps readers understand what the product does, why they might use it, and where to find additional resources.

Product overview pages combine information that overlaps with marketing and READMEs, but focus on linking readers to relevant documentation resources within your product ecosystem.

# PRODUCT NAME Overview

Introductory paragraph(s) explaining what the product is, what it does, what problems it solves, and the benefits to the user.
This content will overlap with marketing for this product.
For example, see the [AWS Lambda marketing page](https://aws.amazon.com/lambda/features/) and the [AWS Lambda documentation page](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html).

## Product diagram

Include a basic diagram showing how the product works and how components connect at a high level.
Reference the [Google guide to documentation illustrations](https://developers.google.com/tech-writing/two/illustrations) for design guidance.
See [Azure Analysis Services](https://learn.microsoft.com/en-gb/azure/analysis-services/analysis-services-overview) and [Azure Cognitive Search](https://learn.microsoft.com/en-gb/azure/search/search-what-is-azure-search) for diagram examples.

## When to use PRODUCT NAME

Describe the use cases for this product, with one use case per major benefit.
Reference [Jira's list of use cases](https://www.atlassian.com/software/jira/guides/use-cases/what-is-jira-used-for) as an example.
See [Azure Cognitive Search use cases](https://learn.microsoft.com/en-gb/azure/search/search-what-is-azure-search#why-use-cognitive-search) for additional guidance.

### (Optional) Intended audience and prerequisites

Identify who this product is for, what technical level is assumed, and any prerequisites or background knowledge readers need.
Include links to preparatory documentation if readers need to learn concepts before using this product.

### (Optional) Key differentiators

Highlight the unique capabilities or features that distinguish this product in the market and address specific user pain points.
Focus on what makes this product a good fit for its intended audience.

### (Optional) Technical requirements and limitations

List system requirements (OS, memory, storage), geo-availability, licensing constraints, and knowledge prerequisites.
Document what this product does NOT do or scenarios it doesn't support to prevent users from discovering limitations after committing to the product.

### (Optional) Development effort and scope

Provide realistic guidance on implementation complexity and time investment required.
Avoid using words like "easy" or "simple."
Instead, qualify effort by audience type and experience level.
For example: "For seasoned engineers familiar with X, implementation typically requires one week.
For new users unfamiliar with X, allow several months for learning and integration."

## PRODUCT NAME components

### Component name

Include an H3 heading for each main component or feature.
Provide one or more paragraphs summarizing what the component is, what it does, and how it relates to the overall product.
Include links in the text to documentation for each component.

### Another component

Repeat the pattern above for each component.

## Install PRODUCT NAME

Add a link to installation documentation and any relevant system requirements.

## Next steps

Provide a brief paragraph or a few sentences guiding readers to the next steps for using this product.
Include links to getting started tutorials and documentation for downloading, installing, and configuring the product.

## Additional resources

### Downloads

- Chef Downloads page for the product

### Learning

- Chef webinars for the product
- Learn Chef tutorials for the product

### Support

- Chef Help Center for the product

### Community

- Section on Chef Discourse for the product
- Section in the Chef Blog for the product

### GitHub repositories

Include links to repositories that advanced users might want to explore.
This could include the main product repository, resource repositories, or on-premises repositories.
```

**Guidelines**:
- The product overview page is often the only documentation page that executives will see---prioritize clarity for all audience levels
- Lead with the market problem or pain point the product solves before describing features or benefits
- Include a product diagram whenever possible to show how components connect
- Make use cases concrete and specific; avoid abstract descriptions like "improves collaboration" or "increases efficiency"
  - Good example: "X product allows writers to simultaneously edit the same document in a browser without installing software"
  - Weak example: "X product helps teams work together more effectively"
- Each use case should map to a distinct product benefit; avoid overly long use case lists
- Link component sections directly to their detailed documentation pages
- Keep introductory paragraphs to one or two paragraphs; avoid dense walls of text
- Follow the file path convention: use `_index.md` in the product subdirectory (for example, `content/habitat/_index.md`)
- Use TOML front matter format and include the `swiftype_search_products` cascade to enable search
- Don't duplicate information that lives in linked documentation---link instead
- Keep the page scannable with clear headings and bulleted lists for resources
- Include only public repositories; exclude private repositories from the GitHub repositories section
- Omit the GitHub repositories section if no public repositories are accessible
- Avoid marketing language like "easy," "simple," or "just"; instead qualify implementation effort by audience type and experience level
- Be honest about implementation complexity; what is straightforward for one audience may be challenging for another
- If marketing content already exists for this product, link to it rather than duplicating; alternatively, create a more technical version focused on implementation
- Optional sections (Intended audience, Key differentiators, Technical requirements, Development effort, Most popular topics) can be excluded if not relevant to your product
- Don't include step-by-step procedures in the overview---link to getting started tutorials or how-to guides instead

---

## README

**Purpose**: The first document a reader finds in a repository. Answers: what is this, who is it for, why should I care, and how do I start? Focus on why a reader would engage with the project, not just what it does.

```markdown
# <Project name>

One sentence describing what the project does and who it's for.

## Project description

Expand on what the project does and why a reader should use it.
Use these patterns:

- "With <project>, you can <verb> <noun>..."
- "<Project> helps you <verb> <noun>..."
- "Unlike <alternative>, <project> <verb> <noun>..."

Include a screenshot or short video if it helps readers understand the project quickly.

## Who is this for

Who can use this project, what problems it helps them solve, and what tasks it helps them accomplish.

## Dependencies

List what the reader needs before they can use the project, and why each dependency is needed.
Link to installation instructions for each.

- <Dependency>: <Why it's needed>---[Install](<link>)

## Installation

```shell
# Install command
<command>
```

## Configuration

| Variable / Option | Default | Description |
|-------------------|---------|-------------|
| `VAR_NAME` | `""` | What it controls |

## Quick start

The minimum steps to get something working. Keep to five steps or fewer.

1. Step one.
2. Step two.

## Usage

```shell
# Description of what this does
command --flag <value>
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| <Error or symptom> | <How to fix it> |

## Contributing

Brief inline guide or link to `CONTRIBUTING.md`.

## How to get help

Where to ask questions, report bugs, or get support.
For example: link to issues, a Slack channel, a mailing list, or Stack Overflow.

## Additional documentation

- [<Doc title>](<link>)---brief description
- [<Doc title>](<link>)---brief description

## License

License name and a link or brief statement.
```

**Guidelines**:
- Lead with why, not just what---explain why a reader should care before describing technical details
- Keep the README scannable: short paragraphs, code blocks for all commands, clear headings
- The quick start must be minimal---the simplest path to a working result
- Include a troubleshooting table for the most common errors new users encounter
- Don't duplicate information that lives in linked docs---link instead
- Revisit the README regularly as the project evolves
