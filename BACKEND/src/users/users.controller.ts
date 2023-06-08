import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Controller('users')
export class UsersController {
<<<<<<< HEAD
  constructor(private readonly usersService: UsersService) {}

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
=======
  constructor(private readonly usersService: UsersService) { }

  @Post('/bootcamp')
  signUpExternal(@Body() createUserDto: CreateUserDto) {
    return this.usersService.signUpBootcamp(createUserDto);
>>>>>>> Nael-HR
  }

  @Get()
  findAll() {
    return this.usersService.findAll();
  }

<<<<<<< HEAD
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(+id, updateUserDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersService.remove(+id);
  }
=======
  @Get('/username/:username')
  findByName(@Param('username') username: string) {
    return this.usersService.findByName(username);
  }

  @Get('/email/:email')
  findByEmail(@Param('email') email: string) {
    return this.usersService.findByEmail(email);
  }

>>>>>>> Nael-HR
}
