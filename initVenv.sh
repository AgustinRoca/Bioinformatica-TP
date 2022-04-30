#!/bin/bash

virtualenv .env
source openVenv.sh
pip install -r requirements.txt
deactivate