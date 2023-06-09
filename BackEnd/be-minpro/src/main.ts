import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';
import express from 'express';
import { ValidationPipe } from '@nestjs/common';

// const corsOptions: CorsOptions = {
//   origin: 'http://localhost:3000', // Replace with your frontend server URL
//   methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'], // Add the allowed HTTP methods
//   allowedHeaders: ['Content-Type', 'Authorization'], // Add the allowed request headers
//   credentials: true, // Set to true if you need to pass cookies or authentication headers
// }
const port = process.env.PORT;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.enableCors();
  await app.listen(port, () => {
    console.log(`Server berjalan di port ${port}`);
  });
}
bootstrap();