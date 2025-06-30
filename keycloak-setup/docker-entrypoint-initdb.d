-- Create database if it doesn't exist
CREATE DATABASE auth;

-- Create user if it doesn't exist
DO
$$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'authserver') THEN
      CREATE ROLE authserver WITH LOGIN PASSWORD 'authserver';
      ALTER ROLE authserver WITH SUPERUSER;
   END IF;
END
$$;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE auth TO authserver;
