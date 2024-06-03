--First log the update to the password
UPDATE "users" SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username" = 'admin';

--now delete the row whwere you have made the update
DELETE FROM "user_logs" WHERE "new_password" = 'oops!';

--now we frame the user emily33
UPDATE "user_logs" SET "new_password" = (
    SELECT "password" FROM "users"
    WHERE "username" = 'emily33'
)
WHERE "type" = 'update'
AND "old_username" = 'admin';
