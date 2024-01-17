import { SharedArray } from "k6/data";
import http from "k6/http";

export const options = {
  vus: 100,
  duration: "10s",
};

const data = new SharedArray("users", function () {
  const result = JSON.parse(open("../seed/new_users.json"));
  return result;
});

export default function () {
  const randomUser = data[Math.floor(Math.random() * data.length)];
  const body = JSON.stringify({
    username: randomUser.username,
    avatar: randomUser.avatar,
  });
  const headers = { "Content-Type": "application/json" };

  http.post("http://localhost:5144/Users", body, { headers });
}
