# Contributing to Fern-lang

First off, thanks for taking the time to contribute! 🎉

The following is a set of guidelines for contributing to Fern-lang. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by the [Fern-lang Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [contact@example.com](mailto:contact@example.com).

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for Fern-lang. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

- **Use the bug report template:** When reporting a bug, use the bug report template provided. It ensures all required details are included and helps maintainers address the issue efficiently.
- **Use the feature request template:** When suggesting an enhancement, use the feature request template provided to ensure all necessary context and details are included.
- **Use the custom issue template:** When submitting any other type of issue.

#### Before Submitting A Bug Report

- **Check the [issues](https://github.com/TheSkyler-Dev/Fern-lang/issues) for existing issues** to avoid duplicates.
- **Update to the latest version** to see if the issue persists.

#### Submitting A Bug Report

- **Use a clear and descriptive title** for the issue.
- **Describe the exact steps which reproduce the problem** in as much detail as possible.
- **Provide specific examples** to demonstrate the steps.
- **Describe the behavior you observed** and explain why you believe this is a bug.
- **Include any relevant screenshots or logs** in your report.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Fern-lang, including completely new features and minor improvements to existing functionality.

#### Before Submitting An Enhancement

- **Check the [issues](https://github.com/TheSkyler-Dev/Fern-lang/issues) for existing suggestions** to avoid duplicates.
- **Perform a cursory search** to see if the enhancement has already been suggested.

#### Submitting An Enhancement

- **Use a clear and descriptive title** for the suggestion.
- **Provide a step-by-step description of the suggested enhancement** in as much detail as possible.
- **Explain why this enhancement would be useful** to most Fern-lang users.
- **Include any relevant examples or context** that would help illustrate the enhancement.

### Contributing to the ANTLR Grammar

Contributions to Fern's ANTLR grammar are welcome! This section outlines specific guidelines for modifying or extending the grammar.

#### Guidelines for Grammar Contributions
- **Understand the existing grammar**: Familiarize yourself with the current grammar to ensure consistency with its structure and style.
- **Follow ANTLR best practices**: Ensure your changes align with [ANTLR best practices](https://github.com/antlr/antlr4/blob/master/doc/index.md).
- **Preserve readability**: Write clear and meaningful rule names, and include comments where necessary.
- **Test your changes**: Update or add tests to confirm that your grammar modifications behave as expected.

#### Before Submitting Grammar Changes
- **Run grammar validation tools**: Ensure no grammatical or syntax errors are introduced.
- **Update documentation**: If your grammar changes impact Fern's syntax or features, update any relevant documentation.
- **Check compatibility**: Ensure that the grammar changes are compatible with existing Fern codebase features.

### Pull Requests

#### Before Submitting A Pull Request

- **Fork the repository** and create your branch from `main`.
- **Follow the coding style** used by the project.
- **Include tests** that cover your changes.
- **Ensure the test suite passes** and your code is linted.
- If you're contributing to the ANTLR grammar, include test cases that cover the new rules or changes introduced.

#### Submitting A Pull Request

- **Create a descriptive title and summary** for your PR.
- **Link to any related issues** in the PR description.
- **Explain the purpose of the PR** and include any relevant context.
- **Ensure your commits are well-organized** and follow the project's commit message guidelines.
- **Use the pull request template:** Make sure to fill out the pull request template to provide all the required information, such as the purpose of the change, related issues, and tests added.

## Style Guides

### Git Commit Messages

- **Use the present tense** ("Add feature" not "Added feature").
- **Use the imperative mood** ("Move cursor to..." not "Moves cursor to...").
- For grammar changes, use a prefix like `Grammar:` in your commit message (e.g., `Grammar: Add support for ternary operator`).
- **Limit the first line to 72 characters or less**.
- **Reference issues and pull requests** liberally after the first line.

### Coding Standards

- Follow the style conventions of Rust, C++, and Swift where applicable.
- Ensure your code is well-documented and comments are clear and concise.
- Write tests for new features or bug fixes to ensure code quality.
- Follow ANTLR-specific conventions for grammar files (e.g., naming rules in lowercase for lexer rules and PascalCase for parser rules).
- Ensure your grammar rules are modular and reusable wherever possible.

## License

By contributing to Fern-lang, you agree that your contributions will be licensed under the [GNU GPL 3.0 License](LICENSE).
