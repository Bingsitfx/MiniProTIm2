import { Module } from '@nestjs/common';

import { SequelizeModule } from '@nestjs/sequelize';

import { JobhireModule } from './jobhire/jobhire.module';

import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'image/product'), // Sesuaikan dengan path ke folder gambar Anda
    }),
    SequelizeModule.forRoot({
      dialect: 'postgres',
      host: 'localhost',
      port: parseInt(process.env.DATABASE_PORT),
      username: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      models: [],
      autoLoadModels: true,
    }),

    JobhireModule,

  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
