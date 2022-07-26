const fetch = require('node-fetch')
const shell = require('shelljs')

const args = process.argv.slice(2).join(' ')

const upCaseFirst = string => {
  return string.charAt(0).toUpperCase() + string.slice(1)
}

const subbyApiCall = async () => {
  const postData = {
    apiKey: 284695,
    command: args
  }
  const reponse = await fetch('http://10.0.0.6:5700', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(postData)
  })
  const data = await reponse.json()
  shell.exec(`notify-send 'SubbyBot' '${upCaseFirst(data.response)}'`)
}
subbyApiCall()
