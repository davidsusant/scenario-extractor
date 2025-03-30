Feature: Authentication
    As a user of SauceDemo
    I want to be able to log in with different credentials
    So that I can access the application with different user experiences

    Background:
        Given I am on the SauceDemo login page

    Scenario: Login with valid standard user credentials
        When I enter "standard_user" as username
        And I enter "secret_sauce" as password
        And I click the login button
        Then I should be redirected to the inventory page
        And I should see the product list
        And I should see the shopping cart icon in the header
        And I should see the burger menu icon

    Scenario: Login with locked out user
        When I enter "locked_out_user" as username
        And I enter "secret_sauce" as password
        And I click the login button
        Then I should remain on the login page
        And I should see the error message "Epic sadface: Sorry, this user has been locked out."
        And I should see red X icons in the input fields

    Scenario: Login with problem user
        When I enter "problem_user" as username
        And I enter "secret_sauce" as password
        And I click the login button
        Then I should be redirected to the inventory page
        And I should see the product list with incorrect product images
        And all product images should be the same dog image

    Scenario: Login with performance glitch user
        When I enter "performance_glitch_user" as username
        And I enter "secret_sauce" as password
        And I click the login button
        Then I should be redirected to the inventory page after a noticeable delay
        And the plage should take 3-5 seconds to load

    Scenario: Login with invalid credentials
        When I enter "invalid_user" as username
        And I enter "wrong_password" as password
        And I click the login button
        Then I should remain on the login page
        And I should see the error message "Epic sadface: Username and password do not match any user in this service"
        And I should see red X icons in the input fields
    
    Scenario: Login with empty credentials
        When I leave the username field empty
        And I leave the password field empty
        And I click the login button
        Then I should remain on the login page
        And I should see the error message "Epic sadface: Username is required"
        And I should see a red X icon in the username field

    Scenario: Login with username but empty password
        When I enter "standard_user" as username
        And I leave the password field empty
        And I click the login button
        Then I should remain on the login page
        And I should see the error message "Epic sadface: Password is required"
        And I should see a red X icon in the password field

    Scenario: Logout Functionality
        Given I am logged in as "standard_user"
        When I click the burger menu icon
        Then I should see the side menu open
        When I click "logout" in the side menu
        Then I should be redirected to the login page
        When I click the browser's back button
        Then I should still be in the login page
        And I should not be returned to an authenticated state