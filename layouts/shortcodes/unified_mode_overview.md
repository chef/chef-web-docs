
Unified mode is a setting that combines the compile and converge stages of the Chef Infra Client run into one phase. This replaces Chef Infra's two-pass parsing with single-pass parsing so that resources are executed as soon as they are declared. This results in considerably clearer code, with considerably less Ruby knowledge required to understand the order of operations.
