const dotenv = require("dotenv");

dotenv.config();

const { v4: uuidv4 } = require("uuid");
const fs = require("fs");
const knex = require("knex")({
  client: "pg",
  connection: process.env.DATABASE_URL,
});

function generateRandomUsername() {
  return uuidv4().split("-")[0];
}

function generateAvatarUrl(username) {
  return `https://example.com/avatars/${username}.png`;
}

function generateRandomUser() {
  const username = generateRandomUsername();
  const avatarUrl = generateAvatarUrl(username);
  return { username, avatar: avatarUrl };
}

function generateUsers(count) {
  const users = [];
  for (let i = 0; i < count; i++) {
    users.push(generateRandomUser());
  }
  return users;
}

async function populateUsers(users) {
  await knex("Tweets").del();
  await knex("Users").del();

  await knex.batchInsert(
    "Users",
    users.map((user) => ({ Username: user.username, Avatar: user.avatar }))
  );

  const dbUsers = await knex.select("Id", "Username", "Avatar").from("Users");
  return dbUsers.map((row) => ({
    id: row.Id,
    username: row.Username,
    avatar: row.Avatar,
  }));
}

function generateUsersJson(filepath, users) {
  if (fs.existsSync(filepath)) {
    fs.unlinkSync(filepath);
  }
  fs.writeFileSync(filepath, JSON.stringify(users));
}

async function run(count = 1000000) {
  console.log(`Generating ${count} users...`);
  const users = generateUsers(count);

  console.log("Storing on DB...");
  const dbUsers = await populateUsers(users);

  console.log("Generating JSON file for existing users...");
  generateUsersJson("./seed/existing_users.json", dbUsers);

  console.log("Generating JSON file for new users...");
  const newUsers = generateUsers(count);
  generateUsersJson("./seed/new_users.json", newUsers);

  console.log("Closing DB connection...");
  await knex.destroy();

  console.log("Done!");
}

run();
