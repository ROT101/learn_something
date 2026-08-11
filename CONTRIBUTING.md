# Contributing to learn_something

Thank you for your interest in contributing! This document explains the basic workflow and expectations.

Get started

1. Fork the repository and create a feature branch from main:

   git checkout -b feat/my-change

2. Make small, focused commits with clear messages.

Linting and style

- Run RuboCop for Ruby files:

  gem install rubocop
  rubocop

- Run ShellCheck for shell scripts:

  sudo apt-get install shellcheck
  find . -type f -name "*.sh" -print0 | xargs -0 shellcheck

- Run Flake8 for Python files:

  pip install flake8
  flake8 .

Pull requests

- Open a pull request against the `main` branch.
- Describe the change and why it is needed.
- Link to any related issues.

Branches and commit messages

- Use short-lived feature branches: `feat/...`, `fix/...`, `chore/...`.
- Keep commit messages concise and descriptive.

Code of conduct

Please follow the repository Code of Conduct (CODE_OF_CONDUCT.md). Thank you.