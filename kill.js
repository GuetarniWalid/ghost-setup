require('dotenv').config();
const { execSync } = require('child_process');

const serverIp = process.env.IP_SERVER_HOST;

if (!serverIp) {
  console.error('IP_SERVER_HOST not defined in .env');
  process.exit(1);
}

try {
  console.log(`Connecting to server at ${serverIp}...`);
  execSync(`ssh root@${serverIp} 'chmod +x /opt/ghost/reset-docker.sh && chmod +x /opt/ghost/reset-certbot.sh && /opt/ghost/reset-docker.sh && /opt/ghost/reset-certbot.sh'`, { stdio: 'inherit' });
  console.log('Docker environment reset successfully.');
} catch (error) {
  console.error('Error executing reset script:', error.message);
  process.exit(1);
}
