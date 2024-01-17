import { SharedArray } from "k6/data";
import http from "k6/http";

export const options = {
  vus: 100,
  duration: "10s",
};

// get only existing users based on the existing_users.json file
const data = new SharedArray("users", function () {
  const result = JSON.parse(open("./seed/existing_users.json"));
  return result;
});

export default function () {
  const randomUser = data[Math.floor(Math.random() * data.length)];
  const tweet = {
    tweet: "This is a tweet from k6",
    username: randomUser.username,
  };
  const body = JSON.stringify(tweet);
  const headers = { "Content-Type": "application/json" };

  http.post(`http://localhost:5144/Tweets`, body, { headers });
}
