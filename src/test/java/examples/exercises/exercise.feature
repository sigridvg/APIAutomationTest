Feature: Karate exercise

Background: 
    * url apiUrl
    * def pageRequest = 2
    * def userRequest = 11

Scenario: get, list users
    Given path 'api/users'
    And params { page: '#(pageRequest)'} 
    When method get
    Then status 200
     * match response.page == pageRequest
     * def responseListUser = response.data[4]
     * print responseListUser

Scenario: get, single user comparation
    Given path 'api/users/' + userRequest
    When method get
    Then status 200
     * print response
     * match response.data == { id:11, email: 'george.edwards@reqres.in', first_name: 'George', last_name: 'Edwards',avatar: 'https://reqres.in/img/faces/11-image.jpg'}

Scenario: POST Create
    Given path 'api/users'
    And request { name: 'Peter', job: 'Sales' }
    When method Post
    Then status 201
    And match response == { name: 'Peter', job: 'Sales', id: '#string', createdAt: "#string"}

Scenario: Post, REGISTER – UNSUCCESSFUL
    Given path 'api/register'
    And request { email: 'sydney@fife' }
    When method Post
    Then status 400
     * match response.error contains "Missing password"


#EXTRA EXERCISE
Scenario: EXTRA - get, list users
    Given path 'api/users'
    And params { page: '#(pageRequest)'} 
    When method get
    Then status 200
     * match response.page == pageRequest
     * def responseListUser = response.data[4]
     * print responseListUser
# Get, Single user usign <responseListuser>
    Given path 'api/users/' + userRequest
    When method get
    Then status 200
     * print response
     * match response.data contains responseListUser