#!/usr/bin/env bash
set -xe
pyenv install 2.7.17
pipenv --python 2.7.17
pipenv install
# pipenv run python manage.py collectstatic

wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
echo "Run `heroku login -i` and `pipenv run heroku local`"