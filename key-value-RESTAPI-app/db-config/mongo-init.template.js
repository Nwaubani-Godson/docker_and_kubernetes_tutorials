const keyValueDb = "${KEY_VALUE_DB}";
const keyValueDbUser = "${KEY_VALUE_DB_USER}";
const keyValueDbPassword = "${KEY_VALUE_DB_PASSWORD}";

db = db.getSiblingDB(keyValueDb);

db.createUser(
    {
        user: keyValueDbUser,
        pwd: keyValueDbPassword,
        roles: [
            { role: "readWrite", 
                db: keyValueDb 
            }
        ]
    }
);