const keyValueDb = "key-value-db";
const keyValueDbUser = "key-value-user";
const keyValueDbPassword = "key-value-password";

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