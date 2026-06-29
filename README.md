# Cupcake Corner

![Swift](https://img.shields.io/badge/Swift-5.00+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

A multi-step e-commerce delivery wizard application for ordering custom desserts, built natively with SwiftUI and integrated with external REST APIs.

Cupcake Corner allows users to select cupcake configurations, toggle special baking requests, perform real-time address validation, and process checkout operations via HTTP POST pipelines. The app features an optimized persistent storage system for user profiles and explicit asynchronous UI loading indicators.

## Preview
<img width="24%" alt="Order" src="https://github.com/user-attachments/assets/d5b10d14-302f-45bb-9d24-b3b1e70480ee" />
<img width="24%" alt="Address" src="https://github.com/user-attachments/assets/9dba4887-4e4e-49c8-ab71-8df8e33861d4" />
<img width="24%" alt="Checkout" src="https://github.com/user-attachments/assets/22d26cbc-32ef-44b4-adb6-63278c08b457" />
<img width="24%" alt="Response" src="https://github.com/user-attachments/assets/7e0767b0-ae95-4e43-a34d-4b32e7e47127" />

## Features

* **Dynamic Order Configuration:** Tailor cupcake types, quantities, and optional premium additions like extra frosting or sprinkles with fluid form interactions.
* **Declarative Address Validation:** Real-time checking of delivery input data that intelligently ignores whitespace-only entries to block invalid order submissions.
* **Robust Networking Flow:** Serializes order parameters into strict JSON payload data, executes asynchronous network transmissions using `URLSession`, and maps remote responses.
* **Seamless User Feedback:** Dual-alert system handles both checkout confirmations and detailed parsing/decoding connection failures gracefully.

## About the Project & Challenge

This application was originally built to fulfill **Project 10 (Days 49-52)** of the SwiftUI learning path by Paul Hudson (Hacking with Swift). The core educational goal was to master forms, basic networking pipelines, and understanding asynchronous tasks.

Beyond the core course requirements, the entire codebase was meticulously refactored into a commercial-grade **MVVM** architecture, completely decoupling the domain data layer from view states. Key concepts and best practices implemented include:

* **Pure Domain Structures:** Refactored the core data layers (`Order` and `Address`) into lightweight, framework-independent immutable structures (`struct`). This completely removed heavy `@Observable` macro expansion wrappers and custom `CodingKeys` maps, leaving a compiler-synthesized, clean `Codable` protocol layer.
* **Centralized State & Routing Flow:** Implemented an enterprise-grade `OrderViewModel` as the single source of truth. The instance acts as a persistent reference type that is natively injected across screens using explicit `@Bindable` properties, keeping sub-views reactive yet read-only.
* **Targeted Disk I/O Performance Tuning:** Eradicated expensive global `didSet` observers that triggered redundant `UserDefaults` operations on every basket configuration step. Replaced them with a targeted `.onChange(of:)` modifier on the view layer to execute disk serialization strictly when profile address fields mutate.

🔗 **[Full project description here](https://www.hackingwithswift.com/100/swiftui/49)**

## Project Versioning & Changelog

* **v1.2.0 (Architecture Overhaul & UX Polish)** — `commit: cc62d5`
  Major structural and architectural upgrade. Migrated models into clean structs and introduced `OrderViewModel` to handle state ownership. Relocated `UserDefaults` storage into high-performance targeted `.onChange` view modifiers. Extracted API interactions to the ViewModel layer, integrated an inline `ProgressView` submission tracker, and blocked multi-tap request mutations via native view disabling controls.

* **v1.1.0 (Persistent Delivery Profiles)** — `commit: c6df38a`
  Minor feature release completing the final challenge parameters. Adds baseline auto-loading and auto-saving capabilities for the client profile using JSONEncoder pipelines and system key-value storage.

* **v1.0.0 (Functional MVP Baseline)** — `commit: 974fa3e`
  Initial release matching the standard course curriculum. Sets up vanilla forms, procedural networking functions inside views, and strict inline string validation fields.
