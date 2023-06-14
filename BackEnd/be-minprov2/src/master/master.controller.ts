import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { MasterService } from './master.service';
import { CreateMasterDto } from './dto/create-master.dto';
import { UpdateMasterDto } from './dto/update-master.dto';

@Controller('master')
export class MasterController {
  constructor(private readonly masterService: MasterService) {}

  @Post()
  create(@Body() createMasterDto: CreateMasterDto) {
    return this.masterService.create(createMasterDto);
  }

  @Get('edu')
  findEducation() {
    return this.masterService.findEducation();
  }

  @Get('worktype')
  findWorktype() {
    return this.masterService.findWorktype();
  }

  @Get('jobrole')
  findJobrole() {
    return this.masterService.findJobrole();
  }

  @Get('industry')
  findIndustry() {
    return this.masterService.findIndustry();
  }

  @Get('city')
  findCity() {
    return this.masterService.findCity();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.masterService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMasterDto: UpdateMasterDto) {
    return this.masterService.update(+id, updateMasterDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.masterService.remove(+id);
  }
}
