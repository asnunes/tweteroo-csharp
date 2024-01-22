import { SharedArray } from "k6/data";
import http from "k6/http";

export const options = {
  vus: 10,
  duration: "10s",
};

// get only existing users based on the existing_users.json file
const data = new SharedArray("users", function () {
  const result = JSON.parse(open("../seed/existing_users.json"));
  return result;
});

export default function () {
  const randomUser = data[Math.floor(Math.random() * data.length)];

  http.get(`${process.env.API_URL}/${randomUser.id}`);
}
