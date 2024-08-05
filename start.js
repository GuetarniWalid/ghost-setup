require('dotenv').config();
const { execSync } = require('child_process');

const serverIp = process.env.IP_SERVER_HOST;

if (!serverIp) {
  console.error('IP_SERVER_HOST not defined in .env');
  process.exit(1);
}

try {
  console.log(`Connecting to server at ${serverIp}...`);
  execSync(`ssh root@${serverIp} 'chmod +x /opt/ghost/setup-docker-ghost.sh && chmod +x /opt/ghost/setup-nginx.sh && chmod +x /opt/ghost/setup-certbot.sh && /opt/ghost/setup-nginx.sh && /opt/ghost/setup-certbot.sh && /opt/ghost/setup-docker-ghost.sh'`, { stdio: 'inherit' });
  console.log('Script executed successfully.');
} catch (error) {
  console.error('Error executing script:', error.message);
  process.exit(1);
}
