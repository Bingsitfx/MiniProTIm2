import { Injectable } from '@nestjs/common';
import { CreateUsersAccountDto } from './dto/create-users_account.dto';
import { UpdateUsersAccountDto } from './dto/update-users_account.dto';
import { Sequelize } from 'sequelize-typescript';

@Injectable()
export class UsersAccountService {
  constructor(private sequelize: Sequelize) {}
  create(createUsersAccountDto: CreateUsersAccountDto) {
    return 'This action adds a new usersAccount';
  }

  findAll() {
    return `This action returns all usersAccount`;
  }

  findOne(id: number) {
    return `This action returns a #${id} usersAccount`;
  }

  update(id: number, updateUsersAccountDto: UpdateUsersAccountDto) {
    return `This action updates a #${id} usersAccount`;
  }

  remove(id: number) {
    return `This action removes a #${id} usersAccount`;
  }
}
