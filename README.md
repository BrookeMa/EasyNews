# Overview

A news app to show my coding skills, including Core Data, network, image cache, unit tests, MVVM e.g. Meanwhile, review iOS development and recent learning

The project is not currently complete yet, I am going to write three parts, top headlines, search and setting. 

# API Resource
https://mediastack.com

# TDD
## Network
Network Test Results
| Data        | URLResponse     | Error | State   | Result |
| ----------- | ----------------| ----- | ------- | ------ |
| nil         | nil             | nil   | invalid | ✅ |
| nil         | URLResponse     | nil   | invalid | ✅ |
| nil         | HTTPURLResponse | nil   | invalid | ✅ |
| value       | nil             | nil   | invalid | ✅ |
| value       | nil             | value | invalid | ✅ |
| nil         | URLResponse     | value | invalid | ✅ |
| nil         | HTTPURLResponse | value | invalid | ✅ |
| value       | URLResponse     | value | invalid | ✅ |
| value       | HTTPURLResponse | value | invalid | ✅ |
| value       | URLResponse     | nil   | invalid | ✅ |
| nil         | HTTPURLResponse | nil   | valid   | ✅ |
| nil         | nil             | value | valid   | ✅ |

