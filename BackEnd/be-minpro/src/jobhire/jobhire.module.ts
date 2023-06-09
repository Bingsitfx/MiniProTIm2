import { Module } from '@nestjs/common';
import { SequelizeModule } from '@nestjs/sequelize';
import { JobhireController } from './jobhire.controller';
import { JobhireService } from './jobhire.service';


import { job_category, job_post, client, employee_range, job_photo, talent_apply, talent_apply_progress } from 'models/jobhire'; // Impor entitas yang diperlukan

@Module({
  imports: [
    SequelizeModule.forFeature([job_category, job_post, client, employee_range, job_photo, talent_apply, talent_apply_progress]),
    // SequelizeModule.forRoot({
    //   // Konfigurasi koneksi Sequelize di sini
    // }),
  ],
  controllers: [JobhireController],
  providers: [JobhireService],
})
export class JobhireModule {}
