# Contributing to ImGM

Thank you for considering contributing to ImGM! We appreciate your time and effort in making this project better. To ensure a smooth contribution process, please follow these guidelines.

## Getting Started

1. **Fork the Repository:**

   - Click the "Fork" button at the top right of the repository page.

2. **Clone Your Fork:**

    ```sh
    git clone https://github.com/knno/ImGM.git
    cd ImGM
    ```

3. **Set Upstream Remote:**:

    ```sh
    git remote add upstream https://github.com/[original-owner]/[original-repo].git
    git fetch upstream
    ```

## Making Changes

1. **Create a Branch:**

   - Make sure your branch name adheres to the [Branch Name Guidelines](#branch-name-guidelines) below.

    ```sh
    git checkout -b feat/your-feature-name
    ```

2. **Make Your Changes:**

   - Make sure your code adheres to the project's coding standards.
   - Write or update tests if applicable.

3. **Commit Your Changes:**

    - Make sure your commit messages adhere to the [Commit Message Guidelines](#commit-message-guidelines) below.

    ```sh
    git add .
    git commit -m "feat: My awesome feature"
    ```

4. **Push to Your Fork:**

    ```sh
    git push origin feat/your-feature-name
    ```

5. **Open a Pull Request:**

    - Make sure your pull request adheres to the [Pull Request Guidelines](#pull-request-guidelines) below.

6. **Go to the original repository on GitHub.**

7. **Click on the "Compare & pull request" button.**

8. **Provide a detailed description of your changes.**

### Code Style

- Follow the existing code style in the project.
- Use meaningful structured commit messages.
- Write clear and concise comments when necessary.

### Guidelines

#### Pull Request Guidelines

##### PR Titles

To ensure clear and consistent commit messages, please follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification when writing PR titles. This helps in generating changelogs and understanding the history of changes.

##### Branch Name Guidelines

To maintain a clear and consistent naming convention for branches, please follow these guidelines. Branch names should be descriptive and use hyphens to separate words. The format is as follows:

`<type>/<short-description>`

See [list of types](#list-of-types) below.

###### PR Title Format

Each PR title should consist of a type, an optional scope, and a subject. The format is as follows:

`<type>[optional scope]: <description>`

See [list of types](#list-of-types) below.

#### Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for our commit messages. This makes it easier to generate a changelog and understand the history of changes.

##### Commit Message Format

Each commit message consists of a header, a body (optional), and a footer (optional). The header has a specific format that includes a type, an optional scope, and a subject:

`<type>[optional scope]: <description> [optional body] [optional footer]`

See [list of types](#list-of-types) below.

###### Example Commit Messages

```
feat: add user authentication
fix: resolve login bug
docs: update README with setup instructions
```

By following this format, we ensure consistency and readability in our commit history.

#### List of Types

- **feat:** A new feature.
- **fix:** A bug fix.
- **docs:** Documentation only changes.
- **style:** Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc).
- **perf:** A code change that improves performance.
- **test:** Adding missing tests or correcting existing tests.
- **chore:** Changes to the build process or auxiliary tools and libraries such as documentation generation.


## Running Tests

```sh
npm test
```

## Reporting Issues

- Use the issue tracker to report bugs or suggest enhancements.
- Provide as much detail as possible.

# License

By contributing, you agree that your contributions will be licensed under the [project's license.](LICENSE)
