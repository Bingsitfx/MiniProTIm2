import { Injectable } from '@nestjs/common';
import { CreateEmployeeRangeDto, CreateJobCategoryDto } from './dto/create-jobhire.dto';
import { Sequelize } from 'sequelize-typescript';
import { employee_range, job_category } from '../../models/jobhire';
import handleMessage from 'mhelper/mhelper';


@Injectable()
export class JobhireService {
  constructor(private readonly sequelize: Sequelize) {}

  /* CREATE TABLE JOB_CATEGORY START */
  async createJobCat(createJobCategoryDto: CreateJobCategoryDto) {
    try {
      const handleJobCat = await job_category.findOne({
        where: { joca_name: createJobCategoryDto.joca_name },
      });
      if (handleJobCat) {
        throw new Error('Category Sudah Ada');
      }
      const result = await job_category.create({
        joca_name: createJobCategoryDto.joca_name,
      });
      return handleMessage(result, 'Data berhasil dibuat', 200);
    } catch (error) {
      return handleMessage(error.message, 'Gagal', 400);
    }
  }
  /* CREATE TABLE JOB_CATEGORY END */

  /* CREATE TABLE EMP_RANGE START */
  async createEmpRange(createEmployeeRangeDto: CreateEmployeeRangeDto) {
    try {
      const result = await employee_range.create({
        emra_range_min: createEmployeeRangeDto.emra_range_min,
        emra_range_max: createEmployeeRangeDto.emra_range_max,
      });
      return handleMessage(result, 'Data berhasil dibuat', 200);
    } catch (error) {
      return handleMessage(error.message, 'Gagal', 400);
    }
  }
  /* CREATE TABLE JOB_CATEGORY END */



  findAll() {
    return `This action returns all jobhire`;
  }

  findOne(id: number) {
    return `This action returns a #${id} jobhire`;
  }

  // update(id: number, updateJobhireDto: UpdateJobhireDto) {
  //   return `This action updates a #${id} jobhire`;
  // }

  remove(id: number) {
    return `This action removes a #${id} jobhire`;
  }
}
