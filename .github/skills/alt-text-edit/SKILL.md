---
name: alt-text-edit
description: 'Scan a Markdown file for images, audit every alt text value against accessibility and style guidelines, view each image in the workspace, draft accurate alt text, and edit the file in place. Use when you want to audit and fix image alt text for accessibility compliance and style quality. Triggers on: alt text, alternative text, image accessibility, fix alt text, audit alt text, missing alt text, edit alt text, image descriptions, accessibility, a11y, screen reader.'
argument-hint: "Path to the Markdown file to audit and edit---for example: docs/how-to-deploy.md"
---

# Alt text audit and edit

Runs a four-stage workflow on a Markdown documentation file:

1. **Find images**---scans the file for all image references in Markdown and HTML syntax
2. **Audit alt text**---categorizes each image as missing, empty/decorative, weak, or acceptable
3. **View and draft**---views each image in the workspace and drafts alt text based on the image content, surrounding context, and the rules below
4. **Edit the file**---writes the new alt text into every image reference that needs it

---

## Alt text rules

Apply these rules when auditing and drafting alt text. They're drawn from the
Microsoft Writing Style Guide and the Section 508 guidelines for alternative text.

### Informative images

An informative image conveys content that the reader needs to understand the surrounding
material. Use these rules:

- Communicate the image's **purpose and meaning**, not just its appearance. Ask: what
  information does this image convey? Describe that, not what the image looks like.
- Begin with a capital letter. End with a period, even for fragments.
- Don't prefix alt text with the image type or medium. Phrases like _Screenshot of_,
  _Image of_, _Picture of_, and _Photograph of_ are redundant---screen readers already
  announce that it's an image. Describe the content directly.
- Keep alt text under 150 characters. If the image is too complex to describe concisely,
  write a short summary in the alt text and add a longer description in the surrounding
  text or a linked data table. Add a `<!-- TODO: verify long description -->` comment.
- Don't use the file name or path as alt text.
- Don't repeat text that's already in the surrounding paragraph or caption.
- If text is embedded in the image (labels, callouts, code), include it verbatim unless
  the surrounding text already contains it.
- Match the language of the surrounding content. If the doc is in Spanish, write the
  alt text in Spanish.

### Decorative images

A decorative image adds no information the reader needs---it's purely visual. Use these rules:

- Set the alt attribute to an empty string: `alt=""` in HTML, or `![]()` in Markdown.
- Don't omit the `alt` attribute entirely. Screen readers read the file name when `alt`
  is absent, which is confusing.
- If you are unsure whether an image is decorative, treat it as informative.

### Image type guidance

#### Screenshots in procedures

Describe what the screenshot illustrates in the procedure, not every UI element visible.
The procedural steps already provide element-level detail. Focus on context: what tab,
dialog, or state is being shown.

- Good: `The Create cluster dialog with the Region field highlighted.`
- Avoid: `A dialog box with fields for name, region, tier, and a Create button.`

#### Architecture diagrams and flow charts

Identify the diagram type, then describe the key components and their relationships or the
flow being illustrated. For complex diagrams, provide a short alt text and a text summary
below the image.

- Good: `A Kubernetes cluster with an ingress controller routing external traffic to
  three microservices, each with a sidecar proxy.`
- For very complex diagrams: `CI/CD pipeline overview. See the description below
  for a full text version.`

#### Charts and graphs

State the chart type and describe the key trend or finding, not every data point. If the
chart contains data a reader needs, include a data table below the image or link to one.

- Good: `Deployment frequency by team. Platform team leads at 12 per day; all other
  teams are under 4 per day.`
- Avoid: `Deployment data.`

#### Logos

Logos are never decorative. Describe any significant symbol and include any logo text
verbatim.

- Good: `Kubernetes logo with text: Kubernetes.`
- Avoid: `Logo.`

#### Badge images (CI status, version, license)

Badges are informative. Describe the badge label and its current value.

- Good: `Build status badge: passing.`
- Good: `License badge: Apache 2.0.`

#### Images that contain text

Include the text verbatim in the alt text if the surrounding content doesn't already
contain it.

- Good: `Card with text: Register by January 31st to receive early access.`

#### Button and link images

Focus on what the button or link does, not what the image looks like. Don't start
with "Button" or "Link"---screen readers already announce these roles.

- Good: `Open user settings.`
- Avoid: `Image of two interlocking gears.`

---

## Stage 1: Find all images

Scan the file for every image reference using the following commands.

### Markdown image syntax

```shell
grep -n '!\[' <file>
```

This matches lines containing `![` which is the start of every Markdown image reference,
including those with empty alt text (`![](...)`).

### HTML img tags

```shell
grep -n '<img' <file>
```

Build a list of every image reference found. For each, record:

- **Line number**
- **Current alt text** (the text inside `[]` for Markdown; the `alt` attribute value for HTML)
- **Image path or URL** (the `src` value)

If no images are found, stop and report that the file contains no images.

---

## Stage 2: Audit existing alt text

For each image from Stage 1, assign one of the following categories:

**Missing**---the image has no alt text at all. In Markdown, the brackets are empty: `![]()`.
In HTML, the `alt` attribute is absent.

**Empty/decorative**---the alt attribute is explicitly set to an empty string (`alt=""` in
HTML, or `![]()` in Markdown with intentionally empty brackets). Verify this is intentional:
look at the image and surrounding context. If the image conveys information, reclassify it
as weak or missing.

**Weak**---the alt text is present but doesn't meet quality standards. Common signs:
- The text is the file name or path (for example, `screenshot.png` or `./images/diagram`)
- The text is generic without context (`image`, `screenshot`, `diagram`, `figure`, `photo`)
- The text describes appearance only, not purpose or meaning
- The text repeats the surrounding paragraph verbatim
- The text starts with _Screenshot of_, _Image of_, _Picture of_, _Photograph of_,
  or similar medium-describing phrases

**Acceptable**---the alt text passes all quality checks above.

For each acceptable image, no further action is needed. Proceed to Stage 3 for all missing,
weak, and unverified empty/decorative images.

---

## Stage 3: View images and draft alt text

For each image that needs new or revised alt text:

### Local images

Image paths in Markdown don't always map directly to the file system. Resolve the path
using the following lookup order before calling `view_image`:

1. **Relative path**---resolve the path relative to the Markdown file's location. Most
   standard static-site generators and docs tools use this convention.

2. **Hugo static directory**---Hugo serves files in `static/` at the site root, so a
   path like `product/version/image.png` or `/product/version/image.png` in Markdown
   corresponds to `static/product/version/image.png` in the repo. If the relative
   resolution in step 1 fails, strip any leading `/` from the path, prepend `static/`,
   and look for the file from the repo root.

3. **Other asset directories**---some generators use `assets/`, `public/`, `docs/`, or
   `content/` as the root for served files. If steps 1 and 2 both fail, check whether
   the repo contains one of these directories and repeat the lookup with each as the prefix.

To find the repo root when the Markdown file is nested, search upward for a config file
such as `hugo.toml`, `hugo.yaml`, `config.toml`, `config.yaml`, `mkdocs.yml`, or
`package.json`. The directory containing that file is the repo root.

Once you have resolved the absolute path, use the `view_image` tool to view the image,
then draft alt text based on:

1. What the image actually shows
2. The surrounding text in the document---headings, paragraphs, captions near the image
3. The image type rules in the **Alt text rules** section above

If none of the lookup strategies resolve to an existing file, treat the image as not found
in the workspace and follow the instructions in the **Images not found in the workspace**
section below.

### External images (URLs)

The `view_image` tool can't view external URLs. For images with `http://` or `https://`
paths:

- Read the surrounding context to infer purpose
- Draft the best possible alt text from context alone
- Add a `<!-- TODO: verify alt text---image is external and could not be viewed -->` comment
  on the line above the image reference

### Images not found in the workspace

If a local path can't be resolved (file doesn't exist in the workspace), draft alt text
from context and add a `<!-- TODO: verify alt text---image file not found in workspace -->`
comment on the line above.

---

## Stage 4: Edit the file

Write the drafted alt text into the file for every image that was missing, weak, or
reclassified from decorative.

### Markdown syntax

Replace the existing alt text inside the square brackets:

```markdown
![<new alt text>](<image-path>)
```

For confirmed decorative images, ensure the brackets are empty:

```markdown
![](<image-path>)
```

### HTML syntax

Set or replace the `alt` attribute:

```html
<img src="<image-path>" alt="<new alt text>">
```

For confirmed decorative images:

```html
<img src="<image-path>" alt="">
```

After editing, read the changed lines back to verify the alt text was written correctly
and no surrounding syntax was broken.

---

## Final output

Return the fully edited file content.

After the file content, add an `## Alt text edit summary` section with:

- Total number of images found
- Breakdown by category: how many were missing, weak, decorative, and acceptable before editing
- For each image that was changed: the line number, the old alt text, and the new alt text
- Number of `<!-- TODO: verify -->` comments added and the reason for each
