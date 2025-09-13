#mvn clean test -Dcucumber.features=src/test/java/feature -Dcucumber.filter.tags="@jsonplaceholderTest" -Dplatform=server -Dplatform.name=server -Dapp=my-api-tests
# @jsonplaceholderTest
Feature: jsonplaceholder API Demo

  Scenario: Fetch my jsonplaceholder first object title
    When compose a get request to "https://jsonplaceholder.typicode.com/posts/1" with headers
      | Accept | application/json; charset=UTF-8 |
    And execute and save the response as "postsResponse"
    Then check that response {postsResponse} has "200" as status code and continue
    And check that API response {postsResponse} contains "sunt aut facere repellat provident occaecati excepturi optio reprehenderit" at "$.title"

  Scenario: Fetch my jsonplaceholder 3rd object title
    When compose a get request to "https://jsonplaceholder.typicode.com/posts" with headers
      | Accept | application/json; charset=UTF-8 |
    And execute and save the response as "postsResponse"
    And check that API response {postsResponse} contains "ea molestias quasi exercitationem repellat qui ipsa sit aut" at "$[2].title"

  Scenario: post my jsonplaceholder comment
    When compose a post request to "https://jsonplaceholder.typicode.com/posts" with headers
      | Accept | application/json; charset=UTF-8 |
    And with the below JSON request
      """
      {
        title: 'foo',
        body: 'bar',
        userId: 1,
       }
      """
    And execute and save the response as "postsResponse"
    Then check that response {postsResponse} has "201" as status code and continue
    And check that API response {postsResponse} contains "101" at "$.id"