const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from GitHub Actions!\n');
});

server.listen(80, '0.0.0.0', () => {
  console.log('Server running on port 80');
});