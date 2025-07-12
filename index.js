const express = require('express');
const app = express();
const port = process.env.PORT || 9000;

app.use(express.json());

app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    service: 'medusa-ecs-app'
  });
});

app.get('/', (req, res) => {
  res.json({ 
    message: 'Welcome to Medusa ECS Application!',
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/admin', (req, res) => {
  res.json({ 
    message: 'Admin API endpoint',
    status: 'active'
  });
});

app.get('/store', (req, res) => {
  res.json({ 
    message: 'Store API endpoint',
    status: 'active'
  });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server running on port ${port}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});

process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('SIGINT received, shutting down gracefully');
  process.exit(0);
});
