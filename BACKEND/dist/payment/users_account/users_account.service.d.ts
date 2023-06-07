import { CreateUsersAccountDto } from './dto/create-users_account.dto';
import { UpdateUsersAccountDto } from './dto/update-users_account.dto';
import { Sequelize } from 'sequelize-typescript';
export declare class UsersAccountService {
    private sequelize;
    constructor(sequelize: Sequelize);
    create(createUsersAccountDto: CreateUsersAccountDto): string;
    findAll(): string;
    findOne(id: number): string;
    update(id: number, updateUsersAccountDto: UpdateUsersAccountDto): string;
    remove(id: number): string;
}
