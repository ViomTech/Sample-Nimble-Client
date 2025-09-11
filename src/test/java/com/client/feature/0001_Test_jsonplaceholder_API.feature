Feature: jsonplaceholder API Demo
  @test1
  Scenario: Fetch my jsonplaceholder
    When compose a get request to "https://jsonplaceholder.typicode.com/posts/1" with headers
      | Accept | application/json; charset=UTF-8 |
    And execute and save the response as "{postsResponse}"
    Then check that response "{postsResponse}" has "200" as status code and continue
    And check that API response "{postsResponse}" contains "sunt aut facere repellat provident occaecati excepturi optio reprehenderit" at "$.title"

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
    And execute and save the response as "{postsResponse}"
    Then check that response "{postsResponse}" has "201" as status code and continue
    And check that API response "{postsResponse}" contains "101" at "$.id"