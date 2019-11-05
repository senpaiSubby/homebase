const http = require('http')

const server = http.createServer((req, res) => {
  res.writeHead(500)
  res.end(JSON.stringify({msg: 'Database error.'}))
})

server.listen(1337)
