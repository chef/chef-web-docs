# Editorial style guide rules

When contributing to Markdown documentation, follow these style guidelines in order of precedence:

1. **Chef-specific style** (this guide)
2. **Google Developer Documentation Style Guide** principles
3. **Third-party references** (Merriam-Webster, Chicago Manual of Style, Microsoft Writing Style Guide)

## Markdown formatting

### Voice and tone

- Use active voice for all instructions - make clear who's performing the action
- Use language like "You can" rather than "Users can"
- Write clearly and conversationally
- Be helpful and human
- Passive voice is acceptable when you need to emphasize an object over an action, de-emphasize a subject, or when readers don't need to know who's responsible for the action

### Language

- Use clear, concise language and ensure there are no spelling or grammatical issues
- Avoid jargon and use plain US English to ensure clarity for a global audience
- Use the serial comma in lists
- Use "select" instead of "click" or "click on"
- Use "use" rather than "utilize"
- Don't use Latin abbreviations, for example, instead of "e.g." use "for example", instead of "i.e." use "that is"
- Don't replace "together with" with "alongside"
- Use "go to" instead of "navigate to"
- Instead of "via", use "through", "with", or "using"
- Use contractions, for example, use "don't" rather than "do not" and "aren't" instead of "are not"
- Don't use "please"
- To introduce procedures, use an infinitive phrase with a comma and then the main clause. For example, "To save the document, follow these steps:"
- Write for your audience - assume technical knowledge but explain complex concepts clearly

### Verb tense

- Use present tense for statements that describe general behavior not associated with a particular time
- It's OK to use future tense (will) to distinguish an action that will occur in the future
- Don't use future tense to describe how a product or feature will work after the next release or update
- Avoid the hypothetical future "would" - use present tense instead

### Product names

- Use "Chef 360 Platform" instead of "Chef 360" or "Chef 360 platform"
- Use "Chef Infra Client" instead of "Chef Client" or "client"
- Use "Chef Infra Server" instead of "Chef Server"

### Procedures

When writing step-by-step instructions, follow these guidelines:

#### Introductory sentences

- Introduce procedures with context that isn't part of the section heading
- Don't simply repeat the heading
- End with a colon if it immediately precedes the procedure, or a period if there's material between the introduction and procedure
- Use imperative statements: "To customize the buttons, follow these steps:" or "Customize the buttons:"

#### Single-step procedures

- Format single steps as bulleted lists, not numbered lists
- Write the step in one sentence

#### Multi-step procedures

- Use numbered lists for sequential steps
- Use one step for each action
- Combine small sequential actions using angle brackets (>) for menu selections

#### Step structure

- Start each step with an imperative verb
- Use complete sentences
- Use parallel structure and consistent verb forms
- State the location before the action: "In the Google Cloud console, go to the Monitoring page"
- State the goal before the action: "To start a new document, select **File** > **New** > **Document**"
- Keep results in the same paragraph as the action

#### Optional steps

- Start optional steps with "Optional:" followed by a colon

#### Step organization

- Describe the action first
- List commands if necessary
- Explain placeholders used in commands
- Explain commands in detail if necessary
- List command output if necessary
- Explain results in a separate paragraph if necessary

### Headings and titles

When writing headings and titles, follow these guidelines:

#### Heading text and structure

- Write document titles based on the primary purpose of the document
- For task-based headings, start with a bare infinitive (base form verb): "Create an instance" not "Creating an instance"
- For conceptual headings, use a noun phrase that doesn't start with an -ing verb: "Migration to Google Cloud" not "Migrating to Google Cloud"
- It's OK to use both task-based and conceptual heading styles in the same document
- When possible, avoid using -ing verb forms as the first word in headings or titles
- Avoid repeating the exact page title in a heading on the page

#### Heading format

- Use sentence case for headings and titles (don't use uppercase)
- Don't include numbers in headings to indicate a sequence of sections
- Use punctuation in headings sparingly - punctuation can be a sign that your heading is too complicated
- Only use abbreviations in headings if they're more commonly known than the full term
- Use heading tags to structure content hierarchically (h1, h2, h3, etc. or #, ##, ### in Markdown)
- Don't skip levels of the heading hierarchy - put h3 only under h2, etc.
- Don't use empty headings or headings with no associated content
- Don't put links in headings as they can be confused with heading styles
- Avoid using code items in headings when possible

#### Referring to sections

- When introducing a group of related H3 or lower sections within a larger H2 section, use "the following sections"
- Don't refer to groups of sections as "this section" or "these sections" as these phrases are ambiguous

### User interface elements

When documenting UI elements, follow these guidelines:

#### Focus on the task

- State instructions in terms of what the reader should accomplish, rather than focusing on widgets and gestures
- When practical, avoid reference to UI elements to help readers understand the purpose
- Provide the level of detail that seems useful for the intended audience

#### Format UI element names

- Put UI element names in bold using `**` in Markdown
- This includes buttons, menus, dialogs, windows, list items, or any other feature with a visible name
- Don't use code font for UI elements unless they meet requirements for code font
- Follow the capitalization as it appears on the page, but use sentence case if labels are inconsistent or all uppercase

#### UI element terminology

- **Button**: Use the button's label - "Select **OK**" not "Select the OK button"
- **Checkbox**: Use "the LABEL_NAME checkbox" - "Select the **Automatically check for updates** checkbox"
- **Menu**: Use "In the MENU_NAME menu" or use angle brackets (>) for menu paths
- **Text field**: Use "field" instead of "box" - "In the **Name** field, enter your username"
- **Dialog**: Use "dialog" not "pop-up window"
- **Tab**: Use "the LABEL_NAME tab"
- **Toggle**: Don't use "toggle" as a verb - "To turn on the setting, click the **Wi-Fi** toggle"

#### Verbs for UI interactions

- Use "select" instead of "click" or "click on"
- Use "enter" or "type" for text input
- Use "choose" for selecting from options
- Use "turn on" or "turn off" for toggles and switches
- Use "clear" instead of "uncheck" for checkboxes

#### Prepositions

- Use "in" for: dialogs, fields, lists, menus, panes, windows
- Use "on" for: pages, tabs, toolbars

### Formatting

- Use sentence case for headings (don't use uppercase)
- Use "1." for each item in an ordered list
- If there's one step in a procedure, use one bulleted list item (-) before the step instead of "1."
- Use bulleted lists (rather than numbered lists) when it's just a list of points and not a sequential list of instructions
- Use semantic line breaks where each sentence is on a separate line
- Format code and UI elements consistently

### Links

- Ensure that all hyperlinks are descriptive and provide context for the destination content
- Add mailto link tags for email addresses
- Use meaningful link text that describes the destination

### Quality principles

- Be consistent throughout your documentation
- Prioritize clarity over brevity when necessary
- Break style rules when doing so improves content quality
- Test your instructions to ensure they work as written
- Update documentation when products or processes change

### Accessibility

- Write clear headings that describe the content that follows
- Use alt text for images that describes their content and purpose
- Ensure proper contrast and readability
- Structure content logically with appropriate heading levels
