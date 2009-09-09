# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Thinking_session',
  :secret      => '1589503b9e18fd7b53f7cb1eb4ed9454b5d4e6237354e24636b37e711e2538538ddc59ffea6c29782a7d4a5bae0352f85f18cf41fb91a87171d9c1b701aca181'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
