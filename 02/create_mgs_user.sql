-- This script creates the user named mgs

-- Drop user
DROP USER mgs CASCADE;

-- Create user
CREATE USER mgs IDENTIFIED BY mgs DEFAULT TABLESPACE users;

-- Grant privileges
GRANT ALL PRIVILEGES TO mgs;