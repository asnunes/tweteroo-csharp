import http from "k6/http";

export const options = {
  vus: 1000,
  duration: "120s",
};

export default function () {
  http.get("http://localhost:5144/health");
}
