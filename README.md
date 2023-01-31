# Overview

A news app to show my coding skills to recruiters, including Core Data, network, image cache, unit tests, MVVM e.g. 

The project is not currently complete yet, 

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

