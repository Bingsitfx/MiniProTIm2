import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { JobhireService } from './jobhire.service';
import { CreateEmployeeRangeDto, CreateJobCategoryDto } from './dto/create-jobhire.dto';


@Controller('jobhire')
export class JobhireController {
  constructor(private readonly jobhireService: JobhireService) {}

  //Tabel Job_Category
  @Post('jobcat')
  createJobCat(@Body() createJobCategoryDto: CreateJobCategoryDto) {
    return this.jobhireService.createJobCat(createJobCategoryDto);
  }

  //Tabel Employee_Range
  @Post('emrarange')
  createEmpRange(@Body() createEmployeeRangeDto: CreateEmployeeRangeDto) {
    return this.jobhireService.createEmpRange(createEmployeeRangeDto);
  }

  @Get()
  findAll() {
    return this.jobhireService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.jobhireService.findOne(+id);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updateJobhireDto: UpdateJobhireDto) {
  //   return this.jobhireService.update(+id, updateJobhireDto);
  // }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.jobhireService.remove(+id);
  }
}
