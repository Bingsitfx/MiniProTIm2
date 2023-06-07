import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { UsersAccountService } from './users_account.service';
import { CreateUsersAccountDto } from './dto/create-users_account.dto';
import { UpdateUsersAccountDto } from './dto/update-users_account.dto';

@Controller('users-account')
export class UsersAccountController {
  constructor(private readonly usersAccountService: UsersAccountService) {}

  @Post()
  create(@Body() createUsersAccountDto: CreateUsersAccountDto) {
    return this.usersAccountService.create(createUsersAccountDto);
  }

  @Get()
  findAll() {
    return this.usersAccountService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersAccountService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUsersAccountDto: UpdateUsersAccountDto) {
    return this.usersAccountService.update(+id, updateUsersAccountDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersAccountService.remove(+id);
  }
}
