const http = require("http");

const server = http.createServer((req, res) => {
    res.writeHead(200, {"Content-Type": "text/plain"});
    res.end("Welcome! The example is working!");
})

server.listen(3000, "0.0.0.0", () => {
    console.log("Server running at http://0.0.0.0:3000");
})