# chimney
CVWO Assignment 3: TODO App

chimney is a small TODO app based on Rails. It allows users to add, edit, delete TODOs. On top of that, users may add deadlines, labels, mark TODOs as done, as well as search through them.

## Author

Shen Yichen
A0091173J

## Setup

Clone the repository, then run

```
$ bundle install
$ bundle exec rake db:create db:migrate
```

Then to start the development sever, run

```
$ bin/rails server
```

### Production

#### Gems

To deploy the app on a production server, install the production gems instead.

```
$ bundle install --deployment --without development test
```

#### Database

The app uses sqlite by default, change `config/database.yml` for the production database configuration.

When you're done, add the secret key to the production environment. You can generate a secret key with `bundle exec rake secret`. Copy the output into the correct field in `config/secrets.yml`.

> You might want to change the permissions for `database.yml` and `secrets.yml` to ensure security.

Then, while ensuring that your database server is running, execute the following commands:

```
bundle exec rake assets:precompile db:create db:migrate RAILS_ENV=production
```

#### Server and URL

Change the last line in `config/environments/production.rb`, to the relative URL of the app. Then run the server with whichever production server you wish.

#### Cron

`cron/crontab.txt` contains two tasks that could be scheduled with:

```bash
$ crontab cron/crontab.txt
```

The first task is an auto upgrade script meant for deployment with Phusion Passenger. You may change it accordingly.

The second task clears the database of old application sessions (see below), using the custom rake task `cron:clear_sessions`.

## Functionality

### Back-end

The back-end comprises of 3 elements. Sessions, as explained below, errands, which are models of TODO tasks, and labels, which classify TODO task. Both errands and labels are CRUD resources, and belong to a session.

#### Application sessions

The app creates a new "application session" for each new visitor. All content creates by the user would be local to such a application session.

The application session ID is stored in the user's cookie store, and the app will retrieve the right session based on the cookie when a user returns.

A user may also save the session by copying the URL. He may also visit any other session present, though it will not replace the ID in his session store unless explicitly triggered by him.

##### Access Time

Any method in `ErrandsController` and `LabelsController` will evoke a callback that will update the access time of an application session. This attribute will be used to keep track of old sessions that have not been accessed by the user for a long time. They will be picked up by the Cron task and destroyed accordingly.

They can also be manually removed by:

```
$ rake cron:clear_sessions
```

#### Toggling

Errands, or TODO tasks, have a method named `toggle`, which flips the boolean that marks if a particular TODO is completed.

### Front-end

#### CSS Framework

The front-end makes use of the Materialize CSS framework, based on the Material Design by Google. Reference can be found [here](http://materializecss.com/).

#### Colors

The front-end shows TODOs with different colors based on their state (overdue, not due, completed, etc...). It reads from a virtual attribute in Errands and assigns the color based on the attribute.
