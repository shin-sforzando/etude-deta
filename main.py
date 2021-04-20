#!/usr/bin/env python3

import os

import jsonify as jsonify
from deta import Deta
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv(verbose=True)

app = FastAPI()
deta = Deta(os.environ.get('DETA_PROJECT_KEY'))
users = deta.Base('users')


@app.get('/')
def read_root():
    users.insert({
        'name': 'Geordi',
        'title': 'Chief Engineer'
    })

    return 'Hello Deta!'


@app.get('/users/{user_key}')
def read_user(user_key: str):
    user = users.get(user_key)
    return user if user else jsonify({'error': 'Not found'}, 404)
