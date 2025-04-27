const KeyValueDb = process.env.KEY_VALUE_DB;
const KeyValueDbUser = process.env.KEY_VALUE_DB_USER;
const KeyValueDbPassword = process.env.KEY_VALUE_DB_PASSWORD;

console.log('INITIALIZING: Key-Value DB User');
db = db.getSiblingDB(KeyValueDb);

db.createUser({
    user: KeyValueDbUser,
    pwd: KeyValueDbPassword,
    roles: [
        { role: "readWrite", 
            db: KeyValueDb }
    ]
});