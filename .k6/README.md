This is the K6 NPM package to run K6 tests from NodeJS.

To use it, you need to have K6 installed on your system. You need to follow the steps below:

1. Install K6 on your system. You can find the instructions [here](https://k6.io/docs/getting-started/installation/).

2. Install the package dependencies:

```bash
npm install
```

3. Run the tests:

```bash
npm run test <test-file>
```

This command will build the given file and run it on the dist folder. You can find the results on the dist folder.

### Where to put tests

All the test should be placed inside the test folder. While any file inside libs folder must be executed directly, the test files must be bundled and then executed due to k6 limitations.
