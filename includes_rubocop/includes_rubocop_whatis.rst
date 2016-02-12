.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|rubocop| is a style and linting tool that analyzes all of the |ruby| code that is authored in a cookbook against a number of rules. (|rubocop| rules are sometimes referred to as "cops".) Each rule examines the code for a specific perspective, after which a list of warnings, deviations from patterns, potential errors, and fatal errors is generated.

|rubocop| is built for |ruby| developers by |ruby| developers. As such, |rubocop| will enforce the conventions that are defined by that community. As users of |chef| and as authors of cookbooks, even though we are using |ruby|, we do not always have the same objectives and goals. That said, there is enough of an overlap that using |rubocop| as part of a cookbook authoring workflow is beneficial.

Each rule in |rubocop| may be enabled and disabled. Custom rules may be created to assist with enforcing standards that are unique to any cookbook authoring team.
