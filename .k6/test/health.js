import http from "k6/http";

export const options = {
  vus: 1000,
  duration: "10s",
  thresholds: {
    http_req_duration: ["p(95)<200"],
    http_req_failed: ["rate<0.01"],
  },
};

export default function () {
  http.get(`${process.env.API_URL}/health`);
}
