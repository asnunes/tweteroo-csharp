import http from "k6/http";

export const options = {
  vus: 1000,
  duration: "10s",
};

export default function () {
  http.get(`${process.env.API_URL}/health`);
}
