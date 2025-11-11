#!/usr/bin/env python3

import jwt
from datetime import datetime, timedelta, timezone
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

def generate_apple_client_secret():
    # Read configuration from environment variables
    team_id = os.getenv('APPLE_TEAM_ID')
    key_id = os.getenv('APPLE_KEY_ID')
    bundle_id = os.getenv('APPLE_BUNDLE_ID')
    key_file = os.getenv('APPLE_KEY_FILE')
    
    # Read the private key
    with open(key_file, 'r') as f: # type: ignore
        private_key = f.read()
    
    # JWT headers
    headers = {
        'kid': key_id,
        'alg': 'ES256'
    }
    
    # JWT payload
    now = datetime.now(timezone.utc)
    payload = {
        'iss': team_id,
        'iat': int(now.timestamp()),
        'exp': int((now + timedelta(days=180)).timestamp()),  # 6 months
        'aud': 'https://appleid.apple.com',
        'sub': bundle_id
    }
    
    # Generate JWT
    client_secret = jwt.encode(payload, private_key, algorithm='ES256', headers=headers)
    
    return client_secret

if __name__ == "__main__":
    try:
        secret = generate_apple_client_secret()
        print("Apple Client Secret:")
        print(secret)
    except Exception as e:
        print(f"Error: {e}")
        print("Make sure to:")
        print("1. Update TEAM_ID in the script")
        print("2. Install PyJWT: pip install PyJWT[crypto]")