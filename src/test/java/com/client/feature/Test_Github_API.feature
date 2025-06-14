@GitHubAPI
Feature: GitHub API Demo

  Scenario: Fetch my GitHub public profile
    When compose a get request to "https://api.github.com/users/octocat" with headers
      | Accept | application/vnd.github+json |
    And execute and save the response as "profileResponse"
    Then check that response "profileResponse" has "200" as status code
    And check that API response "profileResponse" contains "octocat" at "$.login"
    And check that API response "profileResponse" contains "The Octocat" at "$.name"

  Scenario: Fetch my GitHub user details using JWT Token
    When compose a get request to "https://api.github.com/user" with headers
      | Authorization | $1 |
      | Accept        | application/vnd.github+json |
    And execute and save the response as "userProfile"
    And check that response "userProfile" has "200" as status code
    And check that API response "userProfile" contains "80874758" at "$.id"

  Scenario: Create a public repo
    When compose a post request to "https://api.github.com/user/repos" with headers
      | Authorization | $1 |
      | Accept        | application/vnd.github+json |
    And with the below JSON request
  """
  {
    "name": "demo-repo",
    "description": "Created via Nimble API test",
    "private": false
  }
  """
    And execute and save the response as "createRepoResponse"
    Then check that response "createRepoResponse" has "201" as status code
    And check that API response "createRepoResponse" contains "demo-repo" at "$.name"

  Scenario: Verify GitHub repo exists
    When compose a get request to "https://api.github.com/repos/guptaami-commits/demo-repo" with headers
      | Authorization | $1 |
      | Accept        | application/vnd.github+json |
    And execute and save the response as "repoCheckResponse"
    Then check that response "repoCheckResponse" has "200" as status code
    And check that API response "repoCheckResponse" contains "demo-repo" at "$.name"

  Scenario: Delete the repo
    When compose a delete request to "https://api.github.com/repos/guptaami-commits/demo-repo" with headers
      | Authorization | $1 |
      | Accept        | application/vnd.github+json               |
    And execute and save the response as "deleteResponse"
    Then check that response "deleteResponse" has "204" as status code