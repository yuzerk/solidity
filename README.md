## This box is deprecated. It is likely some features in this box will not work as expected.

Consider following [this tutorial](https://forum.openzeppelin.com/t/create-an-erc20-using-truffle-without-writing-solidity/2713) to create an ERC20 with truffle instead.

# TutorialToken Truffle Box

This box has all you need to get started with our [Open Zeppelin (TutorialToken) tutorial](https://trufflesuite.com/guides/robust-smart-contracts-with-openzeppelin/).

## Installation

1. Install Truffle globally.
    ```javascript
    npm install -g truffle
    ```

2. Download the box. This also takes care of installing the necessary dependencies.
    ```javascript
    truffle unbox tutorialtoken
    ```

3. Run the development console.
    ```javascript
    truffle develop
    ```

4. Compile and migrate the smart contracts. Note inside the development console we don't preface commands with `truffle`.
    ```javascript
    compile
    migrate
    ```

5. Run the `liteserver` development server (outside the development console) for front-end hot reloading. Smart contract changes must be manually recompiled and migrated.
    ```javascript
    // Serves the front-end on http://localhost:3000
    npm run dev
    ```

**NOTE**: This box is not a complete dapp, but the starting point for the [Open Zeppelin (TutorialToken) tutorial](http://truffleframework.com/tutorials/robust-smart-contracts-with-openzeppelin). You'll need to complete that for this to function.

## FAQ

* __How do I use this with the EthereumJS TestRPC?__

    It's as easy as modifying the config file! [Check out our documentation on adding network configurations](http://truffleframework.com/docs/advanced/configuration#networks). Depending on the port you're using, you'll also need to update line 16 of `src/js/app.js`.
