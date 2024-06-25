const { writeFileSync } = require('fs');

var userconfig = require('./zelflux/config/userconfig.js');
let repo = new Set(userconfig.initial.blockedRepositories);

repo.add('andrey01');
repo.add('olebedevy');

userconfig.initial.blockedRepositories = Array.from(repo);
const dataToWrite = `module.exports = {
  initial: {
    ipaddress: '${userconfig.initial.ipaddress}',
    zelid: '${userconfig.initial.zelid}',
    kadena: '${userconfig.initial.kadena}',
    testnet: ${userconfig.initial.testnet},
    development: ${userconfig.initial.development},
    apiport: ${userconfig.initial.apiport},
    routerIP: '${userconfig.initial.routerIP}',
    pgpPrivateKey: \`${userconfig.initial.pgpPrivateKey}\`,
    pgpPublicKey: \`${userconfig.initial.pgpPublicKey}\`,
    blockedPorts: ${JSON.stringify(userconfig.initial.blockedPorts)},
    blockedRepositories: ${JSON.stringify(userconfig.initial.blockedRepositories).replace(/"/g, "'")},
  }
}`;

writeFileSync('./zelflux/config/userconfig.js', dataToWrite);
