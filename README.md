# Coins.ph

### Project developed with a modular structure. Firstly you need to install a plugin `$gem install cocoapods-developing-folder`. [Cocoapods-developing-folder](https://github.com/leavez/cocoapods-developing-folder) provides a branch of tools for who heavily use development pods. After that you can run: `$pod install`

### What about a history section - its network layer randomly changing paths in a HistoryTarget.swift after every refresh and delays response every time for 1 sec. (Wallet section has the same opportunity in a WalletTarget.swift, but a random changing is disabled. Only delaying enabled for 3 sec). Exceptions are handled. UseCases, repositories, view model covered with unit tests.

### Project uses a Clean Architecture pattern with MVVMRx Presentation Layer and Coordinator pattern for Routing. Dto objects of a Data Layer are converted to Entities of a Domain Layer. UI layer is written programmatically. There are some libs at individual modules serve for working with the network, exception handling, coordinating, for sharing UI components. Some helpers are written. The CarbonKit library helps to make updating of the UITableView smoothly and allows developers to take the DataDriven approach.


## for all questions write to me on dainiak@icloud.com


