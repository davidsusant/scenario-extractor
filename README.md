# Extract all scenarios in a feature file

How to run the script?
```bash
# copy your feature file to tools/scenario_extractor directory
# ruby scenarios_extractor.rb <relative_feature_file_path>
ruby scenario_extractor.rb features/scenarios/authentication.feature
```

Sample output:
```bash
Extracted Scenarios:
Feature: Authentication
Scenario (Line 10): Login with valid standard user credentials
Tags: @authentication
---
Feature: Authentication
Scenario (Line 20): Login with locked out user
Tags: @authentication
---
Feature: Authentication
Scenario (Line 29): Login with problem user
Tags: @authentication
---
Feature: Authentication
Scenario (Line 38): Login with performance glitch user
Tags: @authentication
---
Feature: Authentication
Scenario (Line 46): Login with invalid credentials
Tags: @authentication
---
Feature: Authentication
Scenario (Line 55): Login with empty credentials
Tags: @authentication
---
Feature: Authentication
Scenario (Line 64): Login with username but empty password
Tags: @authentication
---
Feature: Authentication
Scenario (Line 73): Logout Functionality
Tags: @authentication
---

Total Scenarios: 8
```
