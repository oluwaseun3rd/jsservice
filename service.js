const http = require("http");

const PORT = process.env.PORT || 8080;
const ENV = process.env.ENV || "unknown";

const server = http.createServer((req, res) => {
  res.setHeader("Content-Type", "application/json");

  if (req.url === "/health") {
    res.writeHead(200);
    return res.end(JSON.stringify({ status: "ok" }));
  }

  if (req.url === "/") {
    res.writeHead(200);
    return res.end(
      JSON.stringify({
        message: "hello",
        env: ENV,
      })
    );
  }

  res.writeHead(404);
  res.end(JSON.stringify({ error: "not found" }));
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});