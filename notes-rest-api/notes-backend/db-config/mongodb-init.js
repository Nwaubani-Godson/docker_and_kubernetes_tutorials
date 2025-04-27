const notesDbName = process.env.NOTES_DB_NAME;
const notesDbUser = process.env.NOTES_DB_USER;
const notesDbPassword = process.env.NOTES_DB_PASSWORD;

console.log('INITIALIZING : Notes Db User');

db = db.getSiblingDB(notesDbName);

db.createUser({
    user: notesDbUser,
    pwd: notesDbPassword,
    roles: [
        { role: 'readWrite',
            db: notesDbName
        }
    ]
});