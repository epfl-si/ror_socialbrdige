# Socialbridge

A simple application for caching the authentication credentials for executing
API calls to social networks. Calls are saved and result cached.

## Requirements:
* Ruby version > 2.3
* Ruby Gems and bundler
* SQlite3, nodejs
See the `Dockerfile` for more details.

By default, the app is configured to use sqlite as database because the
requirements are really minimal. You can also use a true SQL database backend:
just modify the `config/database.yml` file accordingly.

### Setup
TODO

In order for the app to work, it have to be registered as application into the
various social network websites that require oauth authentication

 * Facebook
  - https://developers.facebook.com/apps
  - `FACEBOOK_KEY`
  - `FACEBOOK_SECRET`
 * Linkedin
   - https://developer.linkedin.com/my-apps
   - `LINKEDIN_KEY`
   - `LINKEDIN_SECRET`
 * Twitter
  - https://apps.twitter.com/
  - `TWITTER_KEY`
  - `TWITTER_SECRET`
 * Google
  -

## Docker
The app can also be executed as a Docker container with the usual `docker-compose up`.

### Docker setup
1. migrate the database:
   ```
   docker-compose run web bundle exec rails db:migrate
   ```

2. edit the file `go.sh.example` with your private developer key for the various
   services and rename it as `go.sh`. This is just a simple way of setting the
   environment variables needed by the application. You can also edi the
   `docker-compose.yml` file to pass the needed environment variables therein,
   and replace the `go.sh` command with the usual
   `bundle exec rails server -p 3000 -b '0.0.0.0'`


