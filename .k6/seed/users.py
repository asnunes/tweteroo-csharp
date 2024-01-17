import random
import string
import os
import dotenv 
import psycopg2
from psycopg2.extras import execute_values
import uuid
import json


def generate_random_username():
    """Generate a random username of specified length."""
    return uuid.uuid4().hex[:10]

def generate_avatar_url(username):
    """Generate a random avatar url from a username."""
    return f'https://example.com/avatars/{username}.png'

def generate_random_user():
    """Generate a random user."""
    username = generate_random_username()
    avatar_url = generate_avatar_url(username)
    return {
        'username': username,
        'avatar_url': avatar_url,
    }

def generate_users(count):
    """Generate a list of random users."""
    users = []
    for i in range(count):
        users.append(generate_random_user())
    return users

def populate_users(users):
    conn = psycopg2.connect(os.getenv('DATABASE_URL'))
    cur = conn.cursor()

    print('  Cleaning tables...')
    # clean up users table
    cur.execute("DELETE FROM \"Tweets\"")
    cur.execute("DELETE FROM \"Users\"")

    print('  Populating users...')
    # bulk insert users into database
    query = "INSERT INTO \"Users\" (\"Username\", \"Avatar\") VALUES %s"
    execute_values(cur, query, [(user['username'], user['avatar_url']) for user in users])

    print('  Fetching created users...')
    get_all_users_query = "SELECT \"Id\", \"Username\", \"Avatar\" FROM \"Users\""
    cur.execute(get_all_users_query)
    result = cur.fetchall()

    db_users = []
    for row in result:
        db_users.append({
            'id': row[0],
            'username': row[1],
            'avatar': row[2],
        })

    conn.commit()
    cur.close()
    conn.close()

    return db_users

def generate_users_json(filepath, users):
    """Generate a JSON file with random usernames and placeholder avatar URLs."""
    if os.path.exists(filepath):
        os.remove(filepath)

    with open(filepath, mode='w') as file:
        json.dump(users, file)

def run(count=1_000_000):
    print(f'Generating {count} users...')
    users = generate_users(count)

    print('Storing on DB...')
    db_users = populate_users(users)

    print('Generating JSON file for existing users...')
    generate_users_json('./.k6/seed/existing_users.json', db_users)

    print('Generating JSON file for new users...')
    new_users = generate_users(count)
    generate_users_json('./.k6/seed/new_users.json', new_users)

    print('Done!')


if __name__ == '__main__':
    dotenv.load_dotenv('./.k6/.env')
    run()