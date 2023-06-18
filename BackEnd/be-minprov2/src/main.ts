import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import * as bodyParser from 'body-parser';
import * as express from 'express';
import { CorsOptions } from '@nestjs/common/interfaces/external/cors-options.interface';

const port = process.env.PORT;
// async function bootstrap() {
//   const app = await NestFactory.create(AppModule);

//   app.enableCors();

//   // app.use('/image', express.static('images'));

//   app.useGlobalPipes(new ValidationPipe());

//   app.use(bodyParser.urlencoded({ extended: true }));

//   await app.listen(port, () => {
//     console.log(`Listening to port ${port}`);
//   });
// }
// bootstrap();
const corsOption: CorsOptions = {
  origin: ['http://localhost:3000'],
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE'],
};

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe());
  app.enableCors(corsOption);
  await app.listen(port, () => {
    console.log(`Server berjalan di port ${port}`);
  });
}
bootstrap();
