const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from Sachin Dayal!. This is a fully automated deployment using github actions, Terraform, Ansible. For more info visit: https://github.com/Sachin-960/nodejs_github_actions\n');
});

server.listen(80, '0.0.0.0', () => {
  console.log('Server running on port 80');
});