# README

## Purpose

The purpose of this app is to demonstrate the implementation of a REST API using Rails.  The purpose of the API is the following:

The REST API for use by a third party to manage consumer profiles and their brand affinities. A profile will be an object with a unique ID and a list of brand affinities, each with a name and an identifier.

The user should be able to add profiles, edit profiles' brand affinities, return lists of brand affinities for a given profile ID, and return lists of profile IDs for a given brand affinity.

## Setup

* Ruby version

  This app was creating with `Ruby 2.1.8` and `Rails 4.2.7.1`

* System dependencies

* Configuration

* Database initialization

  `rake db:migrate`

* Run the test suite

  `bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment

  A test deployment is available at `https://lit-island-55420.herokuapp.com/`a

  When running locally for development use `http://localhost:<port>/` in place of the `url`

## API Examples

* `GET /profiles?brand=:brand_id`

  * Example Result

    ```
    {
      "profiles": [
        {
          "id": 1,
          "name": "Kyle",
          "brand_ids": []
        },
        {
          "id": 2,
          "name": "Umbel",
          "brand_ids": [
            3
          ]
        }
      ]
    }
    ```

* `POST /profiles`

  * POST data

    ```
    {
      "profile": {
        "name": "Umbel"
      }
    }
    ```

  * Example Result

    ```
    {
      "profile": {
        "id": 3,
        "name": "Umbel",
        "brand_ids": []
      }
    }
    ```

* `GET /profiles/:id`

  * Example Result

    ```
    {
      "profile": {
        "id": 1,
        "name": "Umbel",
        "brand_ids": []
      }
    }
    ```

* `POST /profiles/:id/add_brand`

  * POST data

    ```
    {
      "brand": "1"
    }
    ```

  * Example Result

    ```
    {
      "profile": {
        "id": 3,
        "name": "Umbel",
        "brand_ids": [1]
      }
    }
    ```

* `POST /profiles/:id/remove_brand`

  * POST data

    ```
    {
      "brand": "1"
    }
    ```

  * Example Result

    ```
    {
      "profile": {
        "id": 3,
        "name": "Umbel",
        "brand_ids": []
      }
    }
    ```

* `DEL /profiles/:id`

* `GET /brands?ids[]=:brand_id`

  * Example Result

    ```
    {
      "brands": [
        {
          "id": 1,
          "name": "Vikings"
        },
        {
          "id": 2,
          "name": "Chargers"
        }
      ]
    }
    ```

* `POST /brands`

  * POST data

    ```
    {
      "brand": {
        "name": "Pacers"
      }
    }
    ```

  * Example Result

    ```
    {
      "brand": {
        "id": 3,
        "name": "Pacers"
      }
    }
    ```

* `GET /brands/:id`

  * Example Result

    ```
    {
      "brand": {
        "id": 1,
        "name": "Vikings"
      }
    }
    ```

* `DEL /brands/:id`


* cURL Examples

  * GET `/profiles`

    `curl --request GET --url https://lit-island-55420.herokuapp.com/profiles`
    `curl --request GET --url https://lit-island-55420.herokuapp.com/profiles?brand=1`

  * POST `/profiles`

    ```
      curl --request POST \
      --url https://lit-island-55420.herokuapp.com/profiles \
      --header 'content-type: application/json' \
      --data '{\n  "profile": {\n    "name": "Umbel"\n  }\n}'
    ```

  * GET `/profiles/:id`

    `curl --request GET --url https://lit-island-55420.herokuapp.com/profiles/1`

  * POST `/profiles/:id/add_brand`

    ```
    curl --request POST \
      --url https://lit-island-55420.herokuapp.com/profiles/3/add_brand \
      --header 'content-type: application/json' \
      --data '{ "brand": "3" }'
    ```

  * POST `/profiles/:id/remove_brand`

    ```
    curl --request POST
      --url https://lit-island-55420.herokuapp.com/profiles/3/remove_brand
      --header 'content-type: application/json'
      --data '{ "brand": "1" }'
    ```

  * GET `/brands`

    `curl --request GET --url https://lit-island-55420.herokuapp.com/brands`

    `curl --request GET --url https://lit-island-55420.herokuapp.com/brands?ids[]=1&ids[]=2`

  * POST `/brands`

    ```
    curl --request POST \
      --url https://lit-island-55420.herokuapp.com/brands \
      --header 'content-type: application/json' \
      --data '{\n  "brand": {\n    "name": "Redsox"\n  }\n}'
    ```
