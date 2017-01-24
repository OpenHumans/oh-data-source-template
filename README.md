# Open Humans Data Source template

## About

This is a template Django/Celery app you can use to create an OAuth2 data
source activity for Open Humans. It takes care of some common tasks, and is
also a demo for any project interested in using Open Humans APIs.

### Why Django instead of Flask?

Because small projects sometimes grow.

## Some highlights

### Open Humans authorization

The `complete` function view in `oh_data_source.views` handles receiving
a code from Open Humans, exchanging it for a token, using the token to
retrieve project member ID, and stores this in the `OpenHumansMember` model.

### Asynchronous tasks

The `oh_data_source.celery` sets up asynchronous tasks for the app. This is
used to asynchronously run `xfer_to_open_humans` in `oh_data_source.tasks`.

#### Why asynchonous?

Sometimes it takes a long time. This is bad, the web app will not process
other requests.

### Upload to Open Humans

Template code for uploading an example file to a member account, as well as
demo code for file deletion.

## Local development instructions

### Local requirements.

1. Foreman https://github.com/ddollar/foreman
2. RabbitMQ https://www.rabbitmq.com/download.html
3. pip https://pip.pypa.io/en/stable/installing/

### Install Python requirements.

**Strongly recommend you use [virtualenv](https://virtualenv.pypa.io/en/stable/).**

`pip install -r requirements.txt`

### Set up `.env`

Copy `env.example` to `.env`.

This file contains secrets and other configurations for running the app.
When you use foreman to run this app, it will load `.env` to be environment
variables.<br>**Keep your version SECRET! Never commit it to git.</b>**

### Create Open Humans project

You need to create an OAuth2 project in Open Humans. Start here:
https://www.openhumans.org/direct-sharing/projects/manage/

This is what members join and authorize. Some recommended settings:
1. **Fill out the "Description of data you plan to upload".** This identifies
  your project as a data source. If it's left blank, Open Humans assumes
  your project doesn't plan to add data.
2. **Set the enrollment URL to http://127.0.0.1:5000**
3. **Set the Redirect URL to http://127.0.0.1:5000/complete**

Once the project is created, click on the project's name in your [project
management page](https://www.openhumans.org/direct-sharing/projects/manage/).
This will show the project's information.

Get the `Activity page`, `Client ID` and `Client secret` and set these in
your `.env`. The ID and secret identify and authorizes your app. You'll use
these to get user authorization and manage user data.

**Keep your Client secret private.** Secret data should not be committed to a
repository. In Heroku, this data is set as environment variables. Locally,
you can use a custom `.env`.

### Initalize database and static assets.

Note: Django will use SQLite3 for local development unless you set
`DATABASE_URL` in your `.env`.

In the project directory, run the `migrate` command with foreman:
`foreman run python manage.py migrate`

In the project directory, run the `collectstatic` command with foreman:
`foreman run python manage.py collectstatic`

### Run.

`foreman start`

Go to http://127.0.0.1:5000/

## Heroku deployment notes

Heroku has a lot of features and documentation. The notes below can
help you get started &ndash; you should feel free to explore more!

### Prerequisites and local requirements

1. Create a Heroku account
2. Install the Heroku Commant Line Interface (formally "Heroku Toolbelt"):
https://devcenter.heroku.com/articles/heroku-cli

### Log in and create your app

It's common for the app to have the same name as the project slug. The name
matters if you plan to use Heroku's default domain, which is free (e.g. `https://your-app-name.herokuapp.com`).

1. `heroku login`
2. `heroku apps:create your-app-name`

### Configure and add add-ons

Find your app in the Heroku Dashboard:  https://dashboard.heroku.com/apps

Go to **"Resources tab"** and add:
1. **CloudAMQP** (Little Lemur: Free)
2. **Heroku Postgres** (Hobby Dev: Free)

Go to **"Settings tab"** and add environment variables (as with `.env`):
1. **OH_CLIENT_ID**
2. **OH_CLIENT_SECRET**
3. **OH_ACTIVITY_PAGE**
4. **APP_BASE_URL** (e.g. `https://your-app-name.herokuapp.com` &ndash; no trailing dash!)
5. **SECRET_KEY**
7. **DEBUG** = true when needed

### Push your code.

Run this to initialize and update your code in Heroku:
`git push heroku master`

### Watch logs.

`heroku logs -t`
