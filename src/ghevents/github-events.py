#!/usr/bin/env python3
import os
import json
import requests

GHUSER = os.getenv('GITHUB_USER')
url = f'https://api.github.com/users/{GHUSER}/events'

def retrieve_events(url):
    """Download GitHub events from a URL and return them as a Python object."""
    response_text = requests.get(url).text
    events = json.loads(response_text)
    return events

def print_events(events, n = 5):
    """Loops over the first n items in events and prints each events type and repo location"""
    for x in events[:n]:
        event = x['type'] + ' :: ' + x['repo']['name']
        print(event)

def main():
    """Print the configured GitHub user and API URL, then show recent events."""
    print(GHUSER)
    print(url)
    events = retrieve_events(url)
    print_events(events)

if __name__ == "__main__":
    main()